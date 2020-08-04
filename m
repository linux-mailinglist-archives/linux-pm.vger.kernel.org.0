Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F349123B29D
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 04:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHDCLd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 22:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgHDCLc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2020 22:11:32 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29485C06174A;
        Mon,  3 Aug 2020 19:11:32 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x5so1237069wmi.2;
        Mon, 03 Aug 2020 19:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bt5UFgIVNzgSToTOgOgFgr6yhak9k0sKa89zXpBPQ/o=;
        b=YWK1Rhvx3dGueqYNAcG/nGaRyZZiUP/gaijNg+STgAuFO5r0jP74xHMHKBkRs/08jz
         Npm2RU8T23pWw9ijnJqtMV5LLaKbKy5GhnSQXyTvwsGseW5cJa5xt4SxhtgsxaJsdtzb
         +GQc7Nry2KIPkPR12EDkgk+Qu3nae6pQjRgSQbswTRs2AFM7PHHkeU+xJlujHKXJgvat
         MBzd2XtmP+5Cmt+LFuFt6K84QZG0TGjy66E2XaM/+YZQq+MA6R+1Zxemr7mR1PwSx8IL
         QRAwN1UpNJ2qkqaq9fVIl2uKM0kaO/gArXvdXlkMWC067hUjLQltV/P0T6bk5eoEor0g
         5DUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bt5UFgIVNzgSToTOgOgFgr6yhak9k0sKa89zXpBPQ/o=;
        b=gzjtH4JDnfA3pfoFmVSKUBsJRBqqKTTeZhNm+c+CkXoCSf3gkiDYm3Y2wfdQ2SEsLN
         seoUnx22pc+L0LE6t+X4zu0+WHDDodHh8zhYL7ZnUNzOgYWr6ZIq3/zAAjLv7srrY4Ae
         M3t1iTKHFyeEKHwy1jkovLiGFlhjOooWf22TkWgV9yQiDknIhpXTDMTRdJaIpeCZvPYt
         ZM4C3s1dwOa9oGi3/31PwQqBa/d7gs0Pwtr6KkkvCIu26nywYaAGg8n9Bt3LKUPK1fJj
         xdqxA308XuSQRi/fUgv0tZ2Oss+RWAreSZT3niWLIUu/3FcOqJ26rFblYWKgd+3cD8RZ
         z+Iw==
X-Gm-Message-State: AOAM531hqvq7cMMltkMv5G9iB40NkDfH2twvNBsNcg1wFJFwUF3W2FbG
        jyDAePJtS/TdJZeWhZZEx2LZS3nBmiXK3gpHikQ=
X-Google-Smtp-Source: ABdhPJygM5XTxa4zb95ozIqOuJmCLISli03/sCKeqfp97aweoLOeBsV4PebEwTm8AHk0BUK/6k7Ahkk6FqIBjuehjSI=
X-Received: by 2002:a05:600c:230e:: with SMTP id 14mr1654632wmo.3.1596507090954;
 Mon, 03 Aug 2020 19:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595214246.git.huangqiwu@xiaomi.com> <c9d3199ec18625f9cc4448c3b2049ea2ae80358b.1595214246.git.huangqiwu@xiaomi.com>
 <20200802120015.GA1289@bug> <20200802123742.GA257810@kroah.com>
 <20200802142825.GA20261@amd> <20200802165738.GA293244@kroah.com>
 <20200803114950.oyb3gzyiccybah3u@earth.universe> <20200803115644.GC955269@kroah.com>
In-Reply-To: <20200803115644.GC955269@kroah.com>
From:   ivan <yanziily@gmail.com>
Date:   Tue, 4 Aug 2020 10:11:19 +0800
Message-ID: <CAPtXDt1hMrgJ_9Zs6Zmkzf4b1-QfEcZPp7dKG26G6ZEqBxCgBw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] power: supply: core: add quick charge type property
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@denx.de>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiangfei1@xiaomi.com, Qiwu Huang <huangqiwu@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 3, 2020 at 7:57 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 03, 2020 at 01:49:50PM +0200, Sebastian Reichel wrote:
> > More importantely I prefer not to merge new APIs without any users
> > (i.e. a driver making use of those values). Having a reference
> > driver means, that there is an example how to use the values
> > correctly and proves it is actually needed upstream. Right now
> > this looks like "let's modify the upstream kernel, so that we can
> > easily maintain our out of tree driver".
>
> Agreed.  Qiwu, can you also submit your driver so we can see these
> values be used?

Our driver is based on qualcomm's driver secondary development.

The driver code is for mi 10.

https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/umi-q-oss/drivers/power/supply/qcom/qpnp-smb5.c#L1434

+ case POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE:
+     val->intval = smblib_get_quick_charge_type(chg);
+     break;

https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/umi-q-oss/drivers/power/supply/qcom/smb5-lib.c#L7713

+struct quick_charge adapter_cap[10] = {
+       { POWER_SUPPLY_TYPE_USB,        QUICK_CHARGE_NORMAL },
+       { POWER_SUPPLY_TYPE_USB_DCP,    QUICK_CHARGE_NORMAL },
+       { POWER_SUPPLY_TYPE_USB_CDP,    QUICK_CHARGE_NORMAL },
+       { POWER_SUPPLY_TYPE_USB_ACA,    QUICK_CHARGE_NORMAL },
+       { POWER_SUPPLY_TYPE_USB_FLOAT,  QUICK_CHARGE_NORMAL },
+       { POWER_SUPPLY_TYPE_USB_PD,       QUICK_CHARGE_FAST },
+       { POWER_SUPPLY_TYPE_USB_HVDCP,    QUICK_CHARGE_FAST },
+       { POWER_SUPPLY_TYPE_USB_HVDCP_3,  QUICK_CHARGE_FAST },
+       { POWER_SUPPLY_TYPE_WIRELESS,     QUICK_CHARGE_FAST },
+       {0, 0},
+};
+
+int smblib_get_quick_charge_type(struct smb_charger *chg)
+{
+       int i = 0, rc;
+       union power_supply_propval pval = {0, };
+
+       if (!chg) {
+               dev_err(chg->dev, "get quick charge type faied\n");
+               return -EINVAL;
+       }
+
+       rc = smblib_get_prop_batt_health(chg, &pval);
+       if (rc < 0)
+               smblib_err(chg, "Couldn't get batt health rc=%d\n", rc);
+
+       if ((pval.intval == POWER_SUPPLY_HEALTH_COLD) || (pval.intval
== POWER_SUPPLY_HEALTH_HOT))
+               return 0;
+
+       if ((chg->real_charger_type == POWER_SUPPLY_TYPE_USB_PD) &&
chg->pd_verifed) {
+               return QUICK_CHARGE_TURBE;
+       }
+
+       if (chg->is_qc_class_b)
+               return QUICK_CHARGE_FLASH;
+
+       if ((chg->real_charger_type == POWER_SUPPLY_TYPE_USB_DCP) &&
+                      (chg->hvdcp_recheck_status ||
chg->fake_plug_out == true))
+               return QUICK_CHARGE_FLASH;
+
+       while (adapter_cap[i].adap_type != 0) {
+               if (chg->real_charger_type == adapter_cap[i].adap_type) {
+                       return adapter_cap[i].adap_cap;
+               }
+               i++;
+       }
+
+       return 0;
+}



>
> thanks,
>
> greg k-h



-- 
Thanks

Qiwu
