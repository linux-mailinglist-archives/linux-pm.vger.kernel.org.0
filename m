Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF605E9D3A
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 15:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfJ3OM7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 10:12:59 -0400
Received: from verein.lst.de ([213.95.11.211]:45754 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfJ3OM7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Oct 2019 10:12:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 35A1568B05; Wed, 30 Oct 2019 15:12:56 +0100 (CET)
Date:   Wed, 30 Oct 2019 15:12:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
Message-ID: <20191030141256.GB14252@lst.de>
References: <20191029223214.18889-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029223214.18889-1-linux@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 29, 2019 at 03:32:14PM -0700, Guenter Roeck wrote:
> This patch adds support to read NVME temperatures from the kernel using the
> hwmon API and adds temperature zones for NVME drives. The thermal subsystem
> can use this information to set thermal policies, and userspace can access
> it using libsensors and/or the "sensors" command.

Except in all upper case or all lower case identifier the speling should
always be "NVMe".  Thi also happens a few more places like in the Kconfig
text.

> +static int nvme_hwmon_get_smart_log(struct nvme_hwmon_data *data)
> +{
> +	return nvme_get_log(data->ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> +			    &data->log, sizeof(data->log), 0);
> +}
> +
> +static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			   u32 attr, int channel, long *val)
> +{
> +	struct nvme_hwmon_data *data = dev_get_drvdata(dev);
> +	struct nvme_smart_log *log = &data->log;
> +	int err;
> +	int temp;
> +
> +	err = nvme_hwmon_get_smart_log(data);
> +	if (err)
> +		return err < 0 ? err : -EPROTO;

I think the handling of positive errnos fits better into
nvme_hwmon_get_smart_log.  Also EIO sounds like a better error for
generic NVMe level errors.

> +
> +	switch (attr) {
> +	case hwmon_temp_max:
> +		*val = (data->ctrl->wctemp - 273) * 1000;
> +		break;
> +	case hwmon_temp_crit:
> +		*val = (data->ctrl->cctemp - 273) * 1000;
> +		break;
> +	case hwmon_temp_input:
> +		if (!channel)
> +			temp = le16_to_cpup((__le16 *)log->temperature);

This needs to use get_unaligned_le16, otherwise you'll run into problems
on architectures that don't support unaligned loads.

> +static const struct hwmon_ops nvme_hwmon_ops = {
> +	.is_visible = nvme_hwmon_is_visible,
> +	.read = nvme_hwmon_read,
> +	.read_string = nvme_hwmon_read_string,
> +};
> +
> +static const struct hwmon_chip_info nvme_hwmon_chip_info = {
> +	.ops = &nvme_hwmon_ops,
> +	.info = nvme_hwmon_info,
> +};

Please use tabs to align all the = in an ops structure.

> +#if IS_ENABLED(CONFIG_NVME_HWMON)

No real need to use IS_ENABLED here, a plain ifdef should do it.
