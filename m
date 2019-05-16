Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3999A209CA
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 16:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfEPOcS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 10:32:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41589 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfEPOcS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 10:32:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so1943166pfq.8
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 07:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=USTSvosZQUwlXRNslyvBhxvhMTuh+Dka6Kqkcn0/koE=;
        b=HDZ5DESSf2+w/sQOh+tvO5tlHvqP3VAIAW1HMBygMxEriMoQQsX3DYKC5JS+EvaxMc
         Q0X9rMfzmuaoaEclHD0L7pHm9HVAmpuEngUAqRD7DkAY51M/oWYYLdpiKVLictrefpjW
         9gtLsWXzgLMJqYmwxZY8M3nTQCf0t+/kiMTFT6C83NzLY0G9dzkKAn4Mpu2ElkOp8ebQ
         IBdFpCovUnBnQHztto6/2JYntlnCTta8FBytwMW2knLxKLGtSPUYIDkLeTv+zsscznyL
         KCsq8X6uWZBiEWKCT8kgjlQOqnOPytvbFBOePLYdq05KpT7yx1Sk4iJ8JVALNyz4zD8v
         KP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=USTSvosZQUwlXRNslyvBhxvhMTuh+Dka6Kqkcn0/koE=;
        b=U9t6rKafAlCK0B+qvVbXh5sMqDzdYtLvV2rzgENbRVqJaWi4yPOiOEGS9ugubCcYy8
         f7c7pOIO5xO2eiHq0bWClL5uwYOWakONv6NzZ077g8ZRsaTLWGFrBlnnk3CR/Fpop248
         uayPITevduqp9HqHf+KUHqdRFRDRZOwjcalkG1sUCzkJaEk01hMqab6dYJeGNcZ/zpWm
         XdYvt7E0Hhjy8t13ljnFimSP/HheAjJzsD7To9mQrC5Gi3P80/LFswaZBFfzF9pKcZWo
         IxmUG3btXHpX77W4nK1czr1A5kclBghUdg9C0FPk+Qmv8Imq73q7+UXUtAeXpgbACinY
         4dkA==
X-Gm-Message-State: APjAAAVoU2OdGk5lD2tG7BNhsRV4SumZuZitZDOy0XJGOPlznSsHXRan
        UuX4F5EjpzObwLfCphssPYVSeoSIGJ0=
X-Google-Smtp-Source: APXvYqwCpI4XV53P0/CJGDU6R6OJTH8Uh6keGYXPsieiQpLG8032FEf/PC6zQYVpJaJ17vwm6ROlJQ==
X-Received: by 2002:aa7:880f:: with SMTP id c15mr56520046pfo.100.1558017137148;
        Thu, 16 May 2019 07:32:17 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id f28sm12694022pfk.104.2019.05.16.07.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 07:32:16 -0700 (PDT)
Date:   Thu, 16 May 2019 23:32:14 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] nvme: add thermal zone infrastructure
Message-ID: <20190516143212.GE24001@minwooim-desktop>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> +	if (sensor < 0 || sensor > 8)
> +		return -EINVAL;

Does we really need to check the negative case here ?  Am I missing
something in this context ?  If we really want to check it in this
level, can we check the invalid case in the following function?

> +static struct thermal_zone_device *
> +nvme_thermal_zone_register(struct nvme_ctrl *ctrl, int sensor)
> +{
> +	struct thermal_zone_device *tzdev;
> +	char type[THERMAL_NAME_LENGTH];
> +	int ret;
> +
> +	snprintf(type, sizeof(type), "nvme_temp%d", sensor);

Before preparing "nvme_temp%d", maybe we can make it sure here. :)
What do you say?

> +int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_smart_log *log;
> +	int ret;
> +	int i;
> +
> +	log = kzalloc(sizeof(*log), GFP_KERNEL);
> +	if (!log)
> +		return -ENOMEM;
> +
> +	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> +			   log, sizeof(*log), 0);
> +	if (ret) {
> +		ret = ret > 0 ? -EINVAL : ret;
> +		goto free_log;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> +		struct thermal_zone_device *tzdev;
> +
> +		if (i && !le16_to_cpu(log->temp_sensor[i - 1]))
> +			continue;
> +		if (ctrl->tzdev[i])
> +			continue;
> +
> +		tzdev = nvme_thermal_zone_register(ctrl, i);
> +		if (!IS_ERR(tzdev))
> +			ctrl->tzdev[i] = tzdev;

Quenstion here. Are we okay not to print some warnings here in case
of error returned?
