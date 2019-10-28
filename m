Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E6E733E
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 15:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfJ1OEs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 10:04:48 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18864 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfJ1OEs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 10:04:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5db6f5830000>; Mon, 28 Oct 2019 07:04:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 28 Oct 2019 07:04:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 28 Oct 2019 07:04:46 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Oct
 2019 14:04:45 +0000
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 28 Oct 2019 14:04:45 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id 20A04428E8; Mon, 28 Oct 2019 16:04:43 +0200 (EET)
Date:   Mon, 28 Oct 2019 16:04:43 +0200
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/18] Consolidate and improve NVIDIA Tegra CPUIDLE
 driver(s)
Message-ID: <20191028140443.GA27141@pdeschrijver-desktop.Nvidia.com>
References: <20191015170015.1135-1-digetx@gmail.com>
 <20191016192133.GB26038@pdeschrijver-desktop.Nvidia.com>
 <72636eb3-5354-eea3-3a51-4975a04186b2@gmail.com>
 <53ee8bd3-5c53-f0aa-175c-7fa3024d0af5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <53ee8bd3-5c53-f0aa-175c-7fa3024d0af5@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572271491; bh=BKPmAnY9n1mE6rVCR5MnqH72B3WVFqsR0H5/VfK49Og=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:
         Content-Transfer-Encoding:In-Reply-To:X-NVConfidentiality:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=drTZtsIs9MN367Mai6PDSm05XrnqtIs43nFgY7VlUf765bcnoofWelcgbWBOS9brP
         F6qku8w82qT5s6XzQxbfWaY+UV1qGzzSaYuSCW44G90GtgQEmkZHBlGJDv6eGLUdFo
         /wXtcEjohJcBtw/mIEPt6NuXkYtbK4VtWTILwi8RlmGsstcb3Ee+WoeJm0AEwEtOvS
         sef5jz/iqU+FFG2CBhKX7V1fufkbZj/HbD1HgzbAweDtM8tj3hhFKCVPr4vuhaZBSw
         NOOqQFsn8bWNgltcJ2j6nSeII820hBBbPTC+U08kjDF+zwl5Jq4IKOkRZ7OwOugz6o
         D8UtfpK9AVwBQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 16, 2019 at 11:14:07PM +0300, Dmitry Osipenko wrote:
> 16.10.2019 22:47, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > 16.10.2019 22:21, Peter De Schrijver =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> On Tue, Oct 15, 2019 at 07:59:57PM +0300, Dmitry Osipenko wrote:
> >>> Hello,
> >>>
> >>> This series does the following:
> >>>
> >>>   1. Unifies Tegra20/30/114 drivers into a single driver and moves it=
 out
> >>>      into common drivers/cpuidle/ directory.
> >>>
> >>>   2. Enables CPU cluster power-down idling state on Tegra30.
> >>>
> >>> In the end there is a quite nice clean up of the Tegra CPUIDLE driver=
s
> >>> and of the Tegra's arch code in general. Please review, thanks!
> >>>
> >>> Changelog:
> >>>
> >>> v6: - Addressed request from Thierry Reding to change the way patches=
 are
> >>>       organized by making changes in a more incremental manner.
> >>>
> >>>     - tegra_sleep_cpu() now checks for the secondary CPUs to be offli=
ne
> >>>       in the "Make outer_disable() open-coded" patch.
> >>>
> >>> v5: - Rebased on a recent linux-next, fixed one minor conflict in Kco=
nfig.
> >>>
> >>>     - Improved commit's message of the "Support CPU cluster power-dow=
n state
> >>>       on Tegra30" patch.
> >>>
> >>>     - The "Support CPU cluster power-down state on Tegra30" patch is =
also
> >>>       got split and now there is additional "Make outer_disable() ope=
n-coded"
> >>>       patch.
> >>>
> >>>     - Made minor cosmetic changes to the "Introduce unified driver fo=
r
> >>>       NVIDIA Tegra SoCs" patch by improving error message and renamin=
g
> >>>       one variable.
> >>>
> >>> v4: - Fixed compilation with !CONFIG_CACHE_L2X0 (and tested that it s=
till
> >>>       works).
> >>>
> >>>     - Replaced ktime_compare() with ktime_before() in the new driver,
> >>>       for consistency.
> >>>
> >>> v3: - Addressed review comments that were made by Jon Hunter to v2 by
> >>>       splitting patches into smaller (and simpler) chunks, better
> >>>       documenting changes in the commit messages and using proper err=
or
> >>>       codes in the code.
> >>>
> >>>       Warnings are replaced with a useful error messages in the code =
of
> >>>       "Introduce unified driver for NVIDIA Tegra SoCs" patch.
> >>>
> >>>       Secondary CPUs parking timeout increased to 100ms because I fou=
nd
> >>>       that it actually may happen to take more than 1ms if CPU is run=
ning
> >>>       on a *very* low frequency.
> >>>
> >>>       Added diagnostic messages that are reporting Flow Controller st=
ate
> >>>       when CPU parking fails.
> >>>
> >>>       Further polished cpuidle driver's code.
> >>>
> >>>       The coupled state entering is now aborted if there is a pending=
 SGI
> >>>       (Software Generated Interrupt) because it will be lost after GI=
C's
> >>>       power-cycling. Like it was done by the old Tegra20 CPUIDLE driv=
er.
> >>>
> >>> v2: - Added patches to enable the new cpuidle driver in the defconfig=
s:
> >>>
> >>>         ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
> >>>         ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig
> >>>
> >>>     - Dropped patches that removed CPUIDLE_FLAG_TIMER_STOP from the i=
dling
> >>>       states because that flag actually doesn't have any negative eff=
ects,
> >>>       but still is correct for the case of a local CPU timer on older=
 Tegra
> >>>       SoCs:
> >>>
> >>>         cpuidle: tegra: Remove CPUIDLE_FLAG_TIMER_STOP from Tegra114/=
124 idle-state
> >>>         cpuidle: tegra: Remove CPUIDLE_FLAG_TIMER_STOP from all state=
s
> >>>
> >>>     - The "Add unified driver for NVIDIA Tegra SoCs" patch got more p=
olish.
> >>>       Tegra30 and Terga114 states are now squashed into a single comm=
on C7
> >>>       state (following Parker TRM terminology, see 17.2.2.2 Power Man=
agement
> >>>       States), more comments added, etc minor changes.
> >>
> >> It would be useful to switch the power state terminology to the one us=
ed
> >> for later chips:
> >>
> >> LP0 becomes SC7
> >> LP1 becomes C1
> >> LP2 becomes CC7
> >>
> >> Meaning of these states is as follows
> >>
> >> C is a core state:
> >>
> >> C1 clock gating
> >> C2 not defined
> >> C3 not defined
> >> C4 not defined
> >> C5 not defined
> >> C6 not defined for ARM cores
> >> C7 power-gating
> >>
> >> CC is a CPU cluster C state:
> >>
> >> CC1 cluster clock gated
> >> CC2 not defined
> >> CC3 fmax@Vmin: not used prior to Tegra186
> >> CC4: cluster retention: no longer supported
> >> CC5: not defined
> >> CC6: cluster power gating
> >> CC7: cluster rail gating
> >>
> >> SC is a System C state:
> >>
> >> SC1: not defined
> >> SC2: not defined
> >> SC3: not defined
> >> SC4: not defined
> >> SC5: not defined
> >> SC6: not defined
> >> SC7: VDD_SOC off
> >=20
> > Hello Peter,
> >=20
> > But new "drivers/cpuidle/cpuidle-tegra.c" uses exactly that terminology=
,
> > please see "cpuidle: Refactor and move NVIDIA Tegra20 driver into
> > drivers/cpuidle/" and further patches. Am I missing something? Or do yo=
u
> > want the renaming to be a separate patch?
> >=20
>=20
> Or maybe you're suggesting to change the names everywhere and not only
> in the cpuidle driver? Please clarify :)

At least some of the variable and function names still say lp2?

Peter.
