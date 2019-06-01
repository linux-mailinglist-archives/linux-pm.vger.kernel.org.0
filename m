Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B90832114
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2019 00:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfFAWtu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Jun 2019 18:49:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44790 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfFAWtu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Jun 2019 18:49:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so6051597pgp.11;
        Sat, 01 Jun 2019 15:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xis5TiMLMAKb33SokWGqbl3qrulKPU+v11atfD6BrqY=;
        b=ivDjuOJHvAn0ZriuGcEETC9HHWLEi7uiSGIvivgAU70XxP+NRDkNuBdXxAKilNZ8j7
         64BhowJvenQiilS3KqlEr1NJ053/R9ouG7HgI3j983kj084VmknxI6r9HnlXdWJDADhH
         K4k6VYpNvMWyIh3vuvWppuRoNlSYNVf6aBaft3wRC5gxhQwUMV/Wy8XoyQFjPL69qWEV
         Jtee/ZVWcNmDJhisplv1FIGi8x5KhhYXeXhseLNOG/OX4RZ0qm8YsPUQ+2VQkrbGqP4Q
         darLUwLY51mKITWlyORCPcX+WWYH5KQ6Fgy4ajeCXkpzLN1Mp3mVRNZpGRnhRJkuY5Vs
         Ivzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xis5TiMLMAKb33SokWGqbl3qrulKPU+v11atfD6BrqY=;
        b=Fs28vjx3FLBM4I/y6J/asP0qcYY5sgciSa2ys0Y9g2ZvJ3HKbnOc3aWjCa31kPXgPP
         nNRlO8dDwGlQLTsdZL4CR4Wn7A0BrZ4Gn9X/zClSY0po00O8j6FUrhUpCnhePgAjflAp
         UogmxTHK2vXiY9Z+abnEgepQvOrlqjzltZkCvk1Vsh6xWt9e4Zb6vOxn+8eYUhRZRK7l
         0KSX4oZK0F/jM7l7+TR17kH9PWG3qpRWjgjW+kqoVtlt2tN0MW2n1vgPypqJObethmA2
         JlcOaFicOukIbVSve+0tSFXiOFPikMVclzILSVs6RW7B3wx15G2qmgOj/wu8uIOlX/r+
         wCig==
X-Gm-Message-State: APjAAAVW92VcvRQMzhZgf90CQitvd/hrcTcR/0Wch5AoOX4uynwiWbps
        3MHbdWB9Mm+nQhmdsHGxNaQ=
X-Google-Smtp-Source: APXvYqxAfL0aWcYl4VMLoCO6v+7T4NRxdJHLlriazYObbehWBr8Fv9rr7JMxAziTNKr+TiFtGRQXIg==
X-Received: by 2002:a63:f410:: with SMTP id g16mr8331650pgi.428.1559429389193;
        Sat, 01 Jun 2019 15:49:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 4sm11860407pfj.111.2019.06.01.15.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 15:49:48 -0700 (PDT)
Date:   Sat, 1 Jun 2019 15:49:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, jdelvare@suse.com, khalid@gonehiking.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        aacraid@microsemi.com, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 3/3] drivers: hwmon: i5k_amb: remove unnecessary #ifdef
 MODULE
Message-ID: <20190601224946.GA6483@roeck-us.net>
References: <1559397700-15585-1-git-send-email-info@metux.net>
 <1559397700-15585-4-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559397700-15585-4-git-send-email-info@metux.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 01, 2019 at 04:01:40PM +0200, Enrico Weigelt, metux IT consult wrote:
> The MODULE_DEVICE_TABLE() macro already checks for MODULE defined,
> so the extra check here is not necessary.
> 
> Signed-off-by: Enrico Weigelt <info@metux.net>
> ---
>  drivers/hwmon/i5k_amb.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
> index b09c39a..b674c2f 100644
> --- a/drivers/hwmon/i5k_amb.c
> +++ b/drivers/hwmon/i5k_amb.c
> @@ -482,14 +482,12 @@ static int i5k_channel_probe(u16 *amb_present, unsigned long dev_id)
>  	{ 0, 0 }
>  };
>  
> -#ifdef MODULE
>  static const struct pci_device_id i5k_amb_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5000_ERR) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5400_ERR) },
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, i5k_amb_ids);
> -#endif
>  

I'd rather know what this table is used for in the first place.

Guenter

>  static int i5k_amb_probe(struct platform_device *pdev)
>  {
> -- 
> 1.9.1
> 
