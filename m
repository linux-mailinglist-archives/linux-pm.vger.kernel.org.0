Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEF0591130
	for <lists+linux-pm@lfdr.de>; Fri, 12 Aug 2022 15:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbiHLNIg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Aug 2022 09:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiHLNIg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Aug 2022 09:08:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A152089921
        for <linux-pm@vger.kernel.org>; Fri, 12 Aug 2022 06:08:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so1168226wrh.3
        for <linux-pm@vger.kernel.org>; Fri, 12 Aug 2022 06:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc;
        bh=nE/YksI/TrTd0HJkGRCbsxN0/Q7VNi+G+yHlFaV4rdg=;
        b=cx+88nfu9Bq4Xhw4QJlzINSAm53bc1vafAFJIcLT8QLNnYQuz07AaolI2SMsGslLj2
         aFNlpzPwnD7eoHQypdh6JldNBT0pPMtmVw/rrK/ZwlHwHjJTU+UkHa6Afd84rM9XY8mr
         X0k9FyTmgHaYRLyYDHnPx9bm71tEz+XzBsgfmWMV6X5dAnkyxrMadPV9TNL2+gdnFyGz
         qajW7ZQ3+H38K870C62QQpbz6SD34M/I80mFT1cs1anx+OEApDL7R48Ozp+96kBxpHN6
         Olx2e70wiACUnf31/3awuT8nK7JStJPbixPCCt/aOFlioSZ4IOvftpBKcY6A/B2NL51d
         A6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nE/YksI/TrTd0HJkGRCbsxN0/Q7VNi+G+yHlFaV4rdg=;
        b=m0GFKe1GzbjqL5UzP4V5GMQnolXuCyVTs1/N6hg8Uugz8LlgB5Rn3dSwZDrwzbJSTy
         fUWXd0z8LTTioful4EKHtugCnuN4Jt47W2WuC5jKqV+k8KToUlyi+iGvsYZYiDNEBrRM
         vz+v3GKvR0Xxkm+sEcSyXjArskkjTh1HL1L0yE2dkQRgc3rcRBkF3ayr5KXjEQ4CI7lP
         28rbyd+8mv5msn0OPT6rIienPahzY4iUn8M1o7W0acJJPgDX+lvT46tGhYZ5sGay0nfc
         e8ChTbS4U01lLwRCOykPUyJc522BgeiR5eJ9XK5w7rqDJj8FKuR6cWKHJGk9gzfNiwvi
         PN2A==
X-Gm-Message-State: ACgBeo3pq9eOkMZLeeVsppGyAqUD8EVU/O/kvY4PeiAEbVEHw5u9yxez
        DkdaoNXoYFDeaMV4TUe+BCauug==
X-Google-Smtp-Source: AA6agR4IM6yACIzgVOhZNfMvn4VAPSBXozEbqHJmfIgFAN7W1HE5KRpQ3mocYJWa0z1wOOyorucoHQ==
X-Received: by 2002:adf:dc87:0:b0:21e:ecad:a6bc with SMTP id r7-20020adfdc87000000b0021eecada6bcmr2098755wrj.218.1660309713144;
        Fri, 12 Aug 2022 06:08:33 -0700 (PDT)
Received: from localhost ([109.180.234.208])
        by smtp.gmail.com with ESMTPSA id q25-20020a1ce919000000b003a3170a7af9sm2878102wmc.4.2022.08.12.06.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 06:08:32 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 2/5] ACPI: scan: Rename acpi_bus_get_parent() and
 rearrange it
References: <12036348.O9o76ZdvQC@kreacher> <2252770.ElGaqSPkdT@kreacher>
Date:   Fri, 12 Aug 2022 14:08:31 +0100
In-Reply-To: <2252770.ElGaqSPkdT@kreacher> (Rafael J. Wysocki's message of
        "Wed, 10 Aug 2022 18:15:24 +0200")
Message-ID: <87edxlk3sg.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The acpi_bus_get_parent() name doesn't really reflect the
> purpose of the function so change it to a more accurate
> acpi_find_parent_acpi_dev().
>
> While at it, rearrange the code inside that function the make it

Typo:                                                  to

> easier to read.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/scan.c |   24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -816,10 +816,9 @@ static const char * const acpi_honor_dep
>  	NULL
>  };
>  
> -static struct acpi_device *acpi_bus_get_parent(acpi_handle handle)
> +static struct acpi_device *acpi_find_parent_acpi_dev(acpi_handle handle)
>  {
> -	struct acpi_device *device;
> -	acpi_status status;
> +	struct acpi_device *adev;
>  
>  	/*
>  	 * Fixed hardware devices do not appear in the namespace and do not
> @@ -830,13 +829,18 @@ static struct acpi_device *acpi_bus_get_
>  		return acpi_root;
>  
>  	do {
> -		status = acpi_get_parent(handle, &handle);
> -		if (ACPI_FAILURE(status))
> -			return status == AE_NULL_ENTRY ? NULL : acpi_root;
> +		acpi_status status;
>  
> -		device = acpi_fetch_acpi_dev(handle);
> -	} while (!device);
> -	return device;
> +		status = acpi_get_parent(handle, &handle);
> +		if (ACPI_FAILURE(status)) {
> +			if (status != AE_NULL_ENTRY)
> +				return acpi_root;
> +
> +			return NULL;
> +		}
> +		adev = acpi_fetch_acpi_dev(handle);
> +	} while (!adev);
> +	return adev;
>  }
>  
>  acpi_status
> @@ -1777,7 +1781,7 @@ void acpi_init_device_object(struct acpi
>  	INIT_LIST_HEAD(&device->pnp.ids);
>  	device->device_type = type;
>  	device->handle = handle;
> -	device->parent = acpi_bus_get_parent(handle);
> +	device->parent = acpi_find_parent_acpi_dev(handle);
>  	fwnode_init(&device->fwnode, &acpi_device_fwnode_ops);
>  	acpi_set_device_status(device, ACPI_STA_DEFAULT);
>  	acpi_device_get_busid(device);
