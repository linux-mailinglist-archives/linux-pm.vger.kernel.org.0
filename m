Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31622562AB9
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jul 2022 07:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiGAFGY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jul 2022 01:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiGAFGY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2022 01:06:24 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A77C61D56
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 22:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656651982; x=1688187982;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SvxleXnvLLu2HAHqskkysVjHRspI2rZmxKBEUNqOG3g=;
  b=XHa+zLe8ELRMQrVhr45MEY0VSy6ErVMEwi0eG+kbSSgKYKbyrEq4uEGg
   cR5/+0q9K90SGa6uT0zb+y85j4kJ2oErATH8EAlJZ/ZZ1iEbbg48cNp+b
   7v4P9zGSMiWyOFcoctP0go+SuNYmd9wOa5QcPSFcOxmgRqoK945CTMKUO
   a2QJStDga8C/z+SaVYYe7aoiCdGYTddygJH9R1vGmN1weCXusBNj033Jv
   P+TJtdg/jdvvV/Kt2bbuPU6bxI9B7SjOrcbjaXYRHUEMq2W4awVpNKqEv
   Tc1da1TYkjRLE6aTzuAO/ydZZYB3ZUG5F4fm6lcPRzQCwfJFznpsdylaB
   A==;
X-IronPort-AV: E=Sophos;i="5.92,236,1650902400"; 
   d="scan'208";a="316670747"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2022 13:06:21 +0800
IronPort-SDR: o2xaJUIDz16Bfk6sr31uGCStYxzkVy58n/7Iq860yGiaJcqOSrj5ft275aR2Ix/wC2luggeMNl
 e/D7oSK9Uio14F08ILgEoiSlpuCd5mgEp+zupoi7T+dZu9WcxIG3nzA8ua6Wu+VQiiIFoIyAXg
 J4pTL3KFMfEHGNSsAs+/X/ijygUkKvKWxi9kM36Kw792l9WJH/b6RJmH0KmZBmoqoTYSMrji7T
 FZBc+TOd2DsEBRUdfS0bsj0/yzetGS+ZMNayim8hdKv99Fnc73DM/FAe89HIsyc2ht1t925l17
 MOcQggd2s2zYvz3fQjSuj0ZG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 21:23:52 -0700
IronPort-SDR: jFukhM1r1L3jCiCTzTOrx2uKRfMl8Spb1/cLylURlKEZGMzkqs+ukEuhA1HwzW/p6rr+o3By5I
 E9wMTMihKkiJEENKAggh3s/H1qf+HFLKBUZVHZd1hqpK036UTgxQPqapupugxsilAc7oyiUjW7
 InqNRnU2sMfUutrhgcwgc6544cy9tB99keTRSmBKcsDyTECR5TAbafFQ8uh3d7AgaRs/UQ0tnH
 V2zJPG8saSGskD+3OrOY4loMZxIN2SpEhBMGXT0KR4GXHn0gIVJjrqFsffcdAfZE9jX2TdjJ9O
 qn4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 22:06:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LZ37x1Cyqz1Rwnl
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 22:06:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656651980; x=1659243981; bh=SvxleXnvLLu2HAHqskkysVjHRspI2rZmxKB
        EUNqOG3g=; b=EmrS2gTUseTPly7tzkn5i4i42v8gT5n5mRrMsDJEjbCUmpLGtbV
        lcbFsEOQyuRuFxezy/eGfLqnI00kAsHK0r58wtfN62aG0zukPe+Xn4Gui8dF0wKg
        pa8m0WoU6c/0T9XMerV2uSjIJhX0d5RgeMvuhUuKLfaaZr5YCGpaSjmYplnCp+ad
        95hGHgo/ftS0spQH4SyHoZHeOPsQw6V53x7HQV8ZN7MkV066KhO49l5+jj5H940t
        QRN1ErqRp1F2QtjB7O58RL7TA1qWTR26o5iZeD8pMshtYn8B965KeOuF4QBQgJn4
        0kzOodBGTQ4neQHv02wS9hm1O1hjr0Nk66Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id r5S7cT4eJqn7 for <linux-pm@vger.kernel.org>;
        Thu, 30 Jun 2022 22:06:20 -0700 (PDT)
Received: from [10.225.163.102] (unknown [10.225.163.102])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LZ37v6Hz4z1RtVk;
        Thu, 30 Jun 2022 22:06:19 -0700 (PDT)
Message-ID: <4e0783ac-b9f5-24ff-f7c6-7b64549b8f9c@opensource.wdc.com>
Date:   Fri, 1 Jul 2022 14:06:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 04/10] ata: ahci: Use `pm_suspend_preferred_s2idle`
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220701023328.2783-1-mario.limonciello@amd.com>
 <20220701023328.2783-4-mario.limonciello@amd.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220701023328.2783-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/1/22 11:33, Mario Limonciello wrote:
> Drop the direct check from the FADT and use the helper instead.

Where is this helper defined ? Seeing that this is patch 4/10, I have no
context for this patch. Please send the whole series next time.

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/ata/ahci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index c1eca72b4575..3f79b732dd00 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1611,7 +1611,7 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap,
>  
>  #ifdef CONFIG_ACPI
>  	if (policy > ATA_LPM_MED_POWER &&
> -	    (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
> +	    pm_suspend_preferred_s2idle()) {
>  		if (hpriv->cap & HOST_CAP_PART)
>  			policy = ATA_LPM_MIN_POWER_WITH_PARTIAL;
>  		else if (hpriv->cap & HOST_CAP_SSC)


-- 
Damien Le Moal
Western Digital Research
