Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9003B7C83
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 06:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhF3EVj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 00:21:39 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:44748 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbhF3EVj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 00:21:39 -0400
Received: by mail-pj1-f50.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so492122pjo.3;
        Tue, 29 Jun 2021 21:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5C6jNx9+TcPzvp0Y/utV/ErF30s90q+UrdhTRBoe9Vo=;
        b=X+xg+HJGv5fWbTtGB+O3+Hw372D+pEbssrnnGALXx7xkg0nXDPBuo/5Bfynb+n3INP
         ZGAE+D4Lxc6HUK4lU0zVCfvEWbVRjV73ib+q9WD4MusdpBitw+IYAxgAc3neodKI4H4g
         k55RPWbwnzs8Z0NHK7/G1bFbE4p2wad0riqOWBzVtYWU4bnCcvZ3J7iJab6JCQlSHeJp
         NMPaUSvjHlTKBpdyN988pUNeeXXCtmwN5fWERLzmUxYiw/3RSTp1UCJ0X4BXOQR/lnhc
         hf1nxEreUkOwPIo+E8Gy4uIDTj5ysK/pG9aFJcMgOzLEij27TCNTV9EiBPZ1dgM5+vp7
         0awQ==
X-Gm-Message-State: AOAM531K4JAGQvXF4zm3SOKXZ/1ZV1Cwt1xhnKA2d0njsun6Uj9CAEE2
        EawIuB1xua/No3Ad2RpHkiW38nB++Dw=
X-Google-Smtp-Source: ABdhPJyqwHl439haX6M/8UMYRPk3/L5Odjfmy1nvUg9KFwvcj5Xxi5YpOcgb4buc2mNlRM+OjOUYBw==
X-Received: by 2002:a17:90b:1014:: with SMTP id gm20mr26889821pjb.165.1625026717342;
        Tue, 29 Jun 2021 21:18:37 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:b36f:1d4c:3b33:df45? ([2601:647:4000:d7:b36f:1d4c:3b33:df45])
        by smtp.gmail.com with ESMTPSA id j2sm19286203pfj.168.2021.06.29.21.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 21:18:36 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] scsi: sd: send REQUEST SENSE for
 BLIST_MEDIA_CHANGE devices in runtime_resume()
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, stern@rowland.harvard.edu
References: <20210628133412.1172068-1-martin.kepplinger@puri.sm>
 <20210628133412.1172068-3-martin.kepplinger@puri.sm>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <37a8e36c-73fd-b8a7-0175-ce6613efc043@acm.org>
Date:   Tue, 29 Jun 2021 21:18:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628133412.1172068-3-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/28/21 6:34 AM, Martin Kepplinger wrote:
> +static int sd_resume_runtime(struct device *dev)
> +{
> +	struct scsi_disk *sdkp = dev_get_drvdata(dev);
> +	struct scsi_device *sdp;
> +	int timeout, retries, res;
> +	struct scsi_sense_hdr my_sshdr;

Since the sense data is ignored, consider removing the "my_sshdr"
declaration and passing NULL as sense pointer to scsi_execute().

> +	if (!sdkp)	/* E.g.: runtime resume at the start of sd_probe() */
> +		return 0;

Are you sure that this code is necessary? There is an
scsi_autopm_get_device(sdp) call at the start of sd_probe() and
scsi_autopm_put_device(sdp) call at the end of sd_probe(). In other
words, no runtime suspend will happen between the
device_initialize(&sdkp->dev) call in sd_probe() and the
dev_set_drvdata(dev, sdkp) call in the same function.

> +	if (sdp->sdev_bflags & BLIST_MEDIA_CHANGE) {
> +		for (retries = 3; retries > 0; --retries) {
> +			unsigned char cmd[10] = { 0 };
> +
> +			cmd[0] = REQUEST_SENSE;

Please define the CDB as follows:

	static const u8 cmd[10] = { REQUEST_SENSE };

> +			/*
> +			 * Leave the rest of the command zero to indicate
> +			 * flush everything.
> +			 */

Shouldn't this comment appear above the CDB definition? Also, what does
"flush everything" mean? According to SPC sense data is discarded from
the device while processing REQUEST SENSE, no matter what the value of
the ALLOCATION LENGTH parameter in that command is. From SPC-6: "the
REQUEST SENSE command with any allocation length clears the sense data."

> +			res = scsi_execute(sdp, cmd, DMA_NONE, NULL, 0, NULL,
> +					   &my_sshdr, timeout,
> +					   sdkp->max_retries, 0, RQF_PM, NULL);

Only one level of retries please. Can sdkp->max_retries be changed into 1?

Thanks,

Bart.
