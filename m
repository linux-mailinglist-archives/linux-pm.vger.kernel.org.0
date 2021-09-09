Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75318404665
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 09:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352660AbhIIHlE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 03:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350893AbhIIHlE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Sep 2021 03:41:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8DBB60F11;
        Thu,  9 Sep 2021 07:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631173195;
        bh=egpCC2/Rz1T8R9MzkBRxG8TPp4Vzys1HYvCrsWdTrVs=;
        h=In-Reply-To:References:To:From:Cc:Subject:Date:From;
        b=WqcCUohtKwje7k52/HxLa+sHklaUZkqDjwVmIw93zgsAjS6OeEHxNMtcySYX2gL97
         mk+8Am8/LDh7ReQtzm14lRMVm7o7eJxSlamlXSxwnfEfHomu1d2oZ4s+HUuk2PQhjY
         MVwlnLRqY9+AXZtKAupCwgInKHxK2AvPSD2cN3R0O+KieWmv5hQmNKhdWUCTDYHDIj
         ZzlnI9DDCUdpCYR3+OPqyUfNyDT9l2o5OQ/S/yvq3i45tXeHcpml3XlmE8oMGXN6M0
         +l06C8mt5kn9YEEiJfXFjmKCJkEqAB9wHA3KafGTID1hij4ZOjt4Ae7W4MPCV/+rGf
         uPbzW9DEBKyBg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2c1a37bcf8cd55c4f9ebb16c876148d9b5ecc78f.camel@linux.intel.com>
References: <20210908161632.15520-1-atenart@kernel.org> <8bd5406ed111aa3c4dc180a21600811c56c6b809.camel@linux.intel.com> <163117137691.4442.5244464351443466921@kwain> <2c1a37bcf8cd55c4f9ebb16c876148d9b5ecc78f.camel@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        amitk@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com
From:   Antoine Tenart <atenart@kernel.org>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal: int340x: fix tcc offset on resume
Message-ID: <163117319244.4442.6983455843812807092@kwain>
Date:   Thu, 09 Sep 2021 09:39:52 +0200
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Srinivas Pandruvada (2021-09-09 09:30:17)
> On Thu, 2021-09-09 at 09:09 +0200, Antoine Tenart wrote:
> > Quoting Srinivas Pandruvada (2021-09-09 07:47:23)
> > >=20
> > > We have to mark for stable. But It mayn't cleanly apply. So we have
> > > to
> > > submit for 5.12+ kernels.
> >=20
> > If this can't be easily applied on stable kernels another approach
> > could
> > be to apply a simple fix (similar to the previous logic) for older
> > kernels[1] and applying this patch only for 5.15+.
> >=20
> > [1] Something like:
> >=20
> > =C2=A0 -static unsigned int tcc_offset_save;
> > =C2=A0 +static unsigned int tcc_offset_save =3D -1;
> >=20
> > =C2=A0=C2=A0 int proc_thermal_resume(struct device *dev)
> > =C2=A0=C2=A0 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct proc_ther=
mal_device *proc_dev;
> > =C2=A0 @@ -352,7 +371,9 @@ int proc_thermal_resume(struct device *dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 proc_dev =3D dev=
_get_drvdata(dev);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 proc_thermal_rea=
d_ppcc(proc_dev);
> >=20
> > =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcc_offset_update(tcc_offs=
et_save);
> > =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tcc_offset_save >=3D 0)
> > =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 tcc_offset_update(tcc_offset_save);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>=20
> This is a better approach. First submit this change with simple fix and
> mark for stable and the other fix for 5.15 kernel.

All right, will do.

Antoine
