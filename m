Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE89178876
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 11:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfG2JdB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 05:33:01 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:43288 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727500AbfG2JdB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 05:33:01 -0400
Received: by mail.z3ntu.xyz (Postfix, from userid 182)
        id 12B98C71AA; Mon, 29 Jul 2019 09:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1564392778; bh=HN+MbnexiLAyOK7zOuZGtlCRFx/AHgiy8HDEo75eHGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CTDMp8e5BBkNLBABgUNlMn7Tfx5A14+WTPdGO2NZNCgpDr0Dwz4yUWIcBhTm5uqJz
         Ha7+huWIML1t2ir8MiuGMm0q4L2Grg17KtzmvIBR7tTj4MftwXgcs/8mIncfcOdwzS
         S9/ZaF26D6rIdkrdLQWZGiwSlXiASvqEcGxv8554=
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on arch-vps
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from g550jk.localnet (80-110-121-20.cgn.dynamic.surfer.at [80.110.121.20])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 31A56C718B;
        Mon, 29 Jul 2019 09:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1564392774; bh=HN+MbnexiLAyOK7zOuZGtlCRFx/AHgiy8HDEo75eHGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SGt0ltx66MUUflBY5dI2vSOMoR+ux/nl3JmLfiLedlCIFimmgOq0/PrS5bybyu2wa
         Ss+SqKbdnfwUIn7Bpjyt8MdJrgW4qLjm5FTc/1NhNxSb8pzYFk83c8R30DTd9JnHyQ
         OoaXjRsN3WL6t86es7kXdvJdVEiVXHFoybvvk9eQ=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-kernel@vger.kernel.org
Cc:     Brian Masney <masneyb@onstation.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 00/15] thermal: qcom: tsens: Add interrupt support
Date:   Mon, 29 Jul 2019 11:32:52 +0200
Message-ID: <2123341.TWUfUUIiFt@g550jk>
In-Reply-To: <20190729090735.GA897@onstation.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org> <CAHLCerNay31+RNQvQZyxMMVyb1mLLfN5BoZbz-M+bMqbmbYwtA@mail.gmail.com> <20190729090735.GA897@onstation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2004695.fh42H4uLbJ"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--nextPart2004695.fh42H4uLbJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 29. Juli 2019 11:07:35 CEST Brian Masney wrote:
> On Sat, Jul 27, 2019 at 12:58:54PM +0530, Amit Kucheria wrote:
> > On Fri, Jul 26, 2019 at 4:59 PM Brian Masney <masneyb@onstation.org> wrote:
> > > On Fri, Jul 26, 2019 at 04:40:16PM +0530, Amit Kucheria wrote:
> > > > How well does cpufreq work on 8974? I haven't looked at it yet but
> > > > we'll need it for thermal throttling.
> > > 
> > > I'm not sure how to tell if the frequency is dynamically changed during
> > > runtime on arm. x86-64 shows this information in /proc/cpuinfo. Here's
> > 
> > > the /proc/cpuinfo on the Nexus 5:
> > Nah. /proc/cpuinfo won't show what we need.
> > 
> > Try the following:
> > 
> > $ grep "" /sys/devices/system/cpu/cpufreq/policy?/*
> > 
> > More specifically, the following files have the information you need.
> > Run watch -n1 on them.
> > 
> > $ grep "" /sys/devices/system/cpu/cpufreq/policy?/scaling_*_freq
> 
> There's no cpufreq directory on msm8974:
> 
>     # ls -1 /sys/devices/system/cpu/
>     cpu0
>     cpu1
>     cpu2
>     cpu3
>     cpuidle
>     hotplug
>     isolated
>     kernel_max
>     modalias
>     offline
>     online
>     possible
>     power
>     present
>     smt
>     uevent
> 
> I'm using qcom_defconfig.
> 
> Brian

Hi Brian,
cpufreq isn't supported on msm8974 yet.
I have these patches [0] in my tree but I'm not sure they work correctly, but I haven't tested much with them. Feel free to try them on hammerhead.

Luca

[0] https://github.com/z3ntu/linux/compare/b0917f53ada0e929896a094b451219cd8091366e...6459ca6aff498c9d12acd35709b4903effc4c3f8

--nextPart2004695.fh42H4uLbJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE66ocILd+OiPORlvAOY2pEqPLBhkFAl0+vUQACgkQOY2pEqPL
BhlwxQ/9FYvDo8UHyQXIQVJJGe70bpy3b2Ea/66omuwaw0BLmetJe2PvQq9IsiVD
TV60M8z4yQdRLp2P3YKQWYg7z3dNRM2mVxX11KfrXdI9rM7xqF+VFwZ21qUY+fht
canQPM1Ln11OJQaZ0fhrH1j9c6fbJ0DoQ3C4AG8CKxzRGIu8FPmWc6XObbxOhEYG
pc3Dy6i0NvldNtgKrxiZ5e1YAjyqdpiKcsw5ZM4xdohcmNj7dLLC6BMebpxzzXRW
NijyZsH9TJkjqLTGT7N7J7jQcEFhpgt0L+HrZOpcKncNpCAxVQDVWezI1AseFIuQ
ZsYjG+QKay+JCfZ3AmwPPVpgm9I+yB3ywzYytb22nrsIX1WzKd2qv1Q7HhNYrJfv
Nar7n7ecAi3cd7wxANrKTRn7FB3hcyIOmwXcoaeTxDRqtPqv6bbXiUGV5uaN2sd3
IHK1XnipnttdfaOnlGW/9JFngiMN6mmlENPiTLL+TMlaCBphOhe302bpK6FWcHI+
AQOXs/cDuYRfH16h/ArfrlnFl6L7Va6MQhKQxOFkhf/NorbJBYcA52E+bQelOChd
Ud6cIOLCIZa64ohYrRZVB/Il8PyC8vl4o+buainb6YUC5yBKxVHzP3Gd2lHboh5T
Gls7AeMsZNULixostOPRdA/KpwO72ePeqU2MtLi577P3qIu3uj4=
=Ia3N
-----END PGP SIGNATURE-----

--nextPart2004695.fh42H4uLbJ--



