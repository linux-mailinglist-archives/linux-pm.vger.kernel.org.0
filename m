Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8785C7B7646
	for <lists+linux-pm@lfdr.de>; Wed,  4 Oct 2023 03:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjJDBZw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Oct 2023 21:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjJDBZw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Oct 2023 21:25:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8EFAF;
        Tue,  3 Oct 2023 18:25:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ED1C433C8;
        Wed,  4 Oct 2023 01:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696382749;
        bh=JgS3ramVNVketws5bP39lQI7MhPBuaFXkJRlYH9Eai0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F6khxS13Ro8IJNttSfiMSm/ZLpzxJQ+4fIyFMTcbxWuMUjbWT3oIc2Ory1GTe75kn
         CS/95sMudVM2GxvE4UBtMat3PXKYgbDjcfehOVud5uAEt2NvavLneA1+flQCezIK69
         dDKHeSp3uqvHaw+iq0czeQzKtfdAYPrG08HCQXH6hpb+kID68FJyXEb2932x8/YBsJ
         iMOz+s0HPTrbJuJXeb0qMcof2GTN6HM7PdSymG8pUsN0OAj984pn4/nZ52vJAC/1b9
         3kEBumiz+vzj7WcZFhgWec6s4pUK564Q/LER+8cL2Ad/N5kT55HOXoKcfPJmykbGwY
         VoGVXOPclMnCw==
Message-ID: <539ec93d-b4f4-1c36-632b-48b89537c9dd@kernel.org>
Date:   Wed, 4 Oct 2023 10:25:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Thinkpad E595 system deadlock on resume from S3
Content-Language: en-US
To:     =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-ide@vger.kernel.org
References: <20230930122054.3cf727a4@meshulam>
 <20231003113135.38384a87@meshulam.tesarici.cz>
 <CAJZ5v0i-FV29TUq8E=FGxB_dRKEJvdoKxzwPGAX0C9vnD7O8eg@mail.gmail.com>
 <20231003130240.0c64bc2e@meshulam.tesarici.cz>
 <CAJZ5v0hvEyVAwA3r5OWv4W_vTbRXt_Oxv+Avvn6N0=1RoN=NCg@mail.gmail.com>
 <20231003144019.24566b05@meshulam.tesarici.cz>
 <CAJZ5v0jttFqKE_CLpF+-vJ_wDAuOo_BUS33htpFUs6idNMugKg@mail.gmail.com>
 <20231003145110.1f22adfb@meshulam.tesarici.cz>
 <CAJZ5v0jbT0DaDpFpLbzO46-Yg6QJ-MrcZAuP+c60q9KpFHAtpQ@mail.gmail.com>
 <20231003171710.2c6a913c@meshulam.tesarici.cz>
 <CAJZ5v0hXZx3ghWrfcTmTzwDJzYqLpzeBhx+CqBjg65Dngc2eRg@mail.gmail.com>
 <20231003220744.07c4fa0a@meshulam.tesarici.cz>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231003220744.07c4fa0a@meshulam.tesarici.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/4/23 05:07, Petr Tesařík wrote:
> I just want to confirm that my understanding of the issue is correct
> now. After applying the patch below, my laptop has just survived half a
> dozen suspend/resume cycles with autosuspend enabled for the SATA SSD
> disk. Without the patch, it usually freezes on first attempt.
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index a371b497035e..87000f89319e 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4768,6 +4768,14 @@ void ata_scsi_dev_rescan(struct work_struct *work)
>  		ata_for_each_dev(dev, link, ENABLED) {
>  			struct scsi_device *sdev = dev->sdev;
>  
> +			/*
> +			 * If the queue accepts only PM, bail out.
> +			 */
> +			if (blk_queue_pm_only(sdev->request_queue)) {
> +				ret = -EAGAIN;
> +				goto unlock;
> +			}
> +
>  			/*
>  			 * If the port was suspended before this was scheduled,
>  			 * bail out.

This seems sensible to me: scsi_rescan_device() only checks that the device is
running, without checking that the device queue is also resumed. So the right
place for this check is scsi_rescan_device():

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 3db4d31a03a1..b05a55f498a2 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1627,12 +1627,13 @@ int scsi_rescan_device(struct scsi_device *sdev)
        device_lock(dev);

        /*
-        * Bail out if the device is not running. Otherwise, the rescan may
-        * block waiting for commands to be executed, with us holding the
-        * device lock. This can result in a potential deadlock in the power
-        * management core code when system resume is on-going.
+        * Bail out if the device or its queue are not running. Otherwise,
+        * the rescan may block waiting for commands to be executed, with us
+        * holding the device lock. This can result in a potential deadlock
+        * in the power management core code when system resume is on-going.
         */
-       if (sdev->sdev_state != SDEV_RUNNING) {
+       if (sdev->sdev_state != SDEV_RUNNING ||
+           blk_queue_pm_only(sdev->request_queue)) {
                ret = -EWOULDBLOCK;
                goto unlock;
        }

Can you try the above to confirm it works for you ? It should, as that is
essentially the same as you did.

-- 
Damien Le Moal
Western Digital Research

