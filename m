Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109253160D7
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 09:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbhBJIVx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 03:21:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233831AbhBJIVv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Feb 2021 03:21:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11BE264E53;
        Wed, 10 Feb 2021 08:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612945270;
        bh=he0NlorbIxJARoaXnx/ZkaYSmkKVl5iSAAFd7uIvSfc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V22ifIVEXJUA7/jZjmwDSOs5j064spwQOa0gzmuIXDT+sfx/dXog1b0n7Fgsafp4D
         QeVJ/ovfRNFMuLdNMLkc/MwytYtzWiievSzmUOL3rA8tvSIzLwS5UIp0QKFLL0IOiC
         tUra+KXJWoKF9P77BuBIuZcbpde3DcNBfbJKjys3JuidWasisYgcBnkEiBlypp6MGG
         0w8TkiquZi4uVO0RcIBZQXqjKU2PAKKk7mfPCJZyMS/19NDaFu9MOabfuc8vcbDWP/
         UPK6LumO/IkiIdmhBAgMDxvrpRkJm1unoaIltqNr218FzH1nc0Wa6/rWxrM1ANhkZL
         UeIVnAqM07+Rw==
Received: by mail-ed1-f45.google.com with SMTP id v7so1798695eds.10;
        Wed, 10 Feb 2021 00:21:09 -0800 (PST)
X-Gm-Message-State: AOAM531TJtWhUilETWATS4SNWHhS/I15xXH4TNTX4sJRLynNOXrKelJg
        iAdO/b/IRS+xMPxn2uYyu27Wied7MC942gLumJ0=
X-Google-Smtp-Source: ABdhPJz6Mu9mo5jCVNryUBj6TLkdEUzdU7aGUTz/GL6lUYh9blsGAgr+btdMcJIlQ25o+MoBVGpbHV7InANBmtsAB6s=
X-Received: by 2002:aa7:ce15:: with SMTP id d21mr2147092edv.246.1612945268495;
 Wed, 10 Feb 2021 00:21:08 -0800 (PST)
MIME-Version: 1.0
References: <20210209230527.26712-1-r-rivera-matos@ti.com>
In-Reply-To: <20210209230527.26712-1-r-rivera-matos@ti.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 10 Feb 2021 09:20:55 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdy4BJMSb7KXhU8vYrJ2+qWPOw0MzTGhXQEgh1xHDZFNw@mail.gmail.com>
Message-ID: <CAJKOXPdy4BJMSb7KXhU8vYrJ2+qWPOw0MzTGhXQEgh1xHDZFNw@mail.gmail.com>
Subject: Re: [PATCH 1/2] power: supply: bq25980: Applies multiple fixes
 brought on
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 10 Feb 2021 at 00:52, Ricardo Rivera-Matos
<r-rivera-matos@ti.com> wrote:
>
> fix: corrects various register step size and offset values
>
> fix: corrects bq25980_get_input_curr_lim() and bq25980_set_input_curr_lim()
>
> fix: corrects bq25980_get_const_charge_curr() and bq25980_set_const_charge_curr()
>
> fix: corrects BQ25960_BATOVP_MIN_uV, BQ25960_BATOVP_OFFSET_uV,
>
> BQ25960_BATOVP_STEP_uV, and BQ25960_BATOVP_MAX_uV
>
> fix: corrects busocp_sc_min and busocp_byp_min members
>
> fix: removes unnecessary polarity check from bq25980_get_adc_ibus()
>
> fix: removes unnecessary polarity check from bq25980_get_adc_ibat()
>
> fix: clamps ibat_adc to match datasheet change

Thanks for the patch.

Only one fix at a time and please exactly describe what is being fixed
using proper sentences (starting with capital letter, ending with a
full stop... and usually description needs multiple of such
sentences). You add here multiple changes without proper description
of a problem being fixed. This is not the correct style of a patch.

Best regards,
Krzysztof
