Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAE64A33F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 16:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfFROCK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 10:02:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46696 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfFROCJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 10:02:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so13230209ljg.13;
        Tue, 18 Jun 2019 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/oq6PYXBAtOBIL4wKV4csfkFnFuFDeoOXik6aWtHD0=;
        b=GeCn97TjTP96BLAQzE4IfeBlBpUmUrC5/KNCzouVXJwEeqUmjmIqhIcYkB80Q/rLLE
         a2h0j8alTs1fNe10AYSdGiR0GZ7iYAXy6SdxPLFK1pbuMHXlVUIx+cIJvRtpSSDx/FQ2
         Q2nsHApR3vVncCXePtgHK12ZldBDypNzToMB8T8DMPukzNXZU+wdh1PoqOrfLaBETsmF
         HpM4jiXIP0B8IFFL8OOpUvpxrEY5Kw0jRheZaX/thzKhP1Mcc2C5xZ3TRMhotKii/iRJ
         2O5/3VUywwYAMXwYesOLhpGKy1buwwFR/Td1W46ZiSQJ4Ne/u/pF0AhKnt2gkKYzTFXR
         hMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/oq6PYXBAtOBIL4wKV4csfkFnFuFDeoOXik6aWtHD0=;
        b=RlykaveC+0gvHQS27/A9V8uiAtaJwn5MRPaJE677NFPzEg8+4vy93MGsICikERPdFm
         qtOppN5T1bAxwS4Thn1/ryw3Zz7njHGq63HlS1Abpvg94pj5q7wNPwrqNt3GiBk3I+OF
         KtaLUhI17/+oXvvCmIBMYl679vIUlidm0KkKh7nUYhP0ZDtY8nlTRPz510Yv0dWX138P
         VD3A3Dly1/T21SmNB/cPNdXWo7zBiHVuX4Njau0X7vzXPtvg1y2yygf3+mBMM0qclh+M
         7qMLq9NsFOyaXV0vOSxWwJ1hrJqcFQyXM828Yd+eVAYm9xUSPvP6YehOZdnDQiamgdju
         ydJQ==
X-Gm-Message-State: APjAAAXS5ekYvzgnUzSkyTUmZILmv4EHidMRDD5wvLCxS4zBJKhorM/a
        xA8YuAYF0vYy/aiZca2S9eZtsERgfpw0J6gbNJg=
X-Google-Smtp-Source: APXvYqxIOSz82C6GotSZhdxpV7t/RdzSd5kUvLAApU7gQ536c/KA+k4lt+HuTF50A3zM6eCuPR9WqxlQ2tgIWWwifTE=
X-Received: by 2002:a2e:a311:: with SMTP id l17mr42584912lje.214.1560866527866;
 Tue, 18 Jun 2019 07:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com>
In-Reply-To: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 18 Jun 2019 11:02:18 -0300
Message-ID: <CAOMZO5BcLaS0gXUPi6oN6vjqagS5yf+rHh+EUjmi-Wi1OX7vqQ@mail.gmail.com>
Subject: Re: [IMX] [DRM]: suspend/resume support
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Pintu,

On Mon, Jun 17, 2019 at 10:50 AM Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> Hi All,
>
> I am trying to implement suspend/resume functionality to to imx-hdmi driver:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/gpu/drm/imx/dw_hdmi-imx.c?h=v4.9.181

Please test a recent kernel, such as 5.1.11. I recall that last time
you reported an issue with the dw hdmi you were running kernel 3.10
with backported patches from 4.9.

Just tried suspend/resume on a imx6q board and HDMI behaves correctly.
