Return-Path: <linux-pm+bounces-36494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6926CBF2CC2
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6673A389E
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 17:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D6B2BF3F4;
	Mon, 20 Oct 2025 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tURujRNg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D720289E13
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982532; cv=none; b=VP2aZQy7G01ged0S7RQ6G5akzcOYHucL5U6m6fFq13MxR3HgN7+6J5kjsTDiVTo9BGMA62Flu4PoEhY7AjNcCf2CnfK/SOMwDeT92UvDe1KG5UFCencH03/5yv6g5we6UaaDHWMzgzmVInEEq9F5AtZvoviz6A9ih9xvA5j1wiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982532; c=relaxed/simple;
	bh=vvj9rbshDG/mJYIvIFilBgDtfu0m0YbNFbdyps7CYhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHV+RCOV4OGyjqEf2FRuUddOcWgFUHplqI7VKLFF3onFLXhyvbBmqwuk7vZb03iScd0r7/OthDCFwkN3Io9c7Rr1J0zPav7ayDuWy5aizTdNv1/whKkCxF6ZisxsBjX8OKjosbYnIHWznONVlI624kKNfRAOhBtjRQphV6QqvDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tURujRNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BECC4CEFE
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 17:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760982531;
	bh=vvj9rbshDG/mJYIvIFilBgDtfu0m0YbNFbdyps7CYhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tURujRNgi7AmohBDrv49upr1mAHzmK/nisfEDCULMQHbiuhZr9IPuTh7dcMmxKIwy
	 B4upXXVtNLhOGjfUGN6MUT3pJSn/++/sHWiO7FGyu6VfltiwMKAfyylX8oCpt2YX9G
	 CeOuCbbhOitkW/1mn4Vb4LvUMxvOVfzAglqwhYzC0izMa21jlPyEbx6HYta9BHGRiM
	 IaIUkfy9cxpdAakYF2/3R7NXdrqmIR8tnL2t4aVT6Byc3RlwdRuRKj3/dkk+apA6xz
	 nOvTIEhx6DkKEaxeKSpzNp2glfhw9okZrUKmJHgKimRreIJ+NG2Ege4Y12B5cxR+3T
	 RxzQwXn+E0JrA==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-443b4d7e927so1558950b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 10:48:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpOlfSPxnWfhU7FxPftgAkB8DyDEK+Iz0oIkIFMbN5ByS+AfTMghcRlK6AWqtlKTWZ13bEZ8cgfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZmmG5lnx2Hkq8xoejl3fTNF2RS9FPymAdNL9+fwYHrnlGRU6R
	oi2MoM04t/wi6I+HC3XJoiJI+Py9dHaJpnzzYb0E3zvr6XUnKcJLVbNd2c/7VimWrjp9ivuGbzp
	016vE99QsBg5/3CVxM8IcFvd1Rs3zyC8=
X-Google-Smtp-Source: AGHT+IEBTcqbNW4WztbsFHgjbUpb2lUwnFWN4p7InrdR0RgRIFe00LDkdSaeIzpzw4iNCju0IktvgqGnApVX0bNPXDo=
X-Received: by 2002:a05:6808:5086:b0:441:8f74:f10 with SMTP id
 5614622812f47-443a30e6210mr6069613b6e.58.1760982531178; Mon, 20 Oct 2025
 10:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014001055.772422-9-changwoo@igalia.com> <202510151223.THlBK6QR-lkp@intel.com>
In-Reply-To: <202510151223.THlBK6QR-lkp@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 19:48:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h-gzxQQAu272z30R8+sDNHA6L=J1w+P2qfLOYF8LRdLQ@mail.gmail.com>
X-Gm-Features: AS18NWDDJNGF4sne2vfcDVyis3SAYtdDq88ce2v-uhPN9EnOmccJ14D_6NBaZtk
Message-ID: <CAJZ5v0h-gzxQQAu272z30R8+sDNHA6L=J1w+P2qfLOYF8LRdLQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/10] PM: EM: Implement em_notify_pd_deleted()
To: kernel test robot <lkp@intel.com>, Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, len.brown@intel.com, 
	pavel@kernel.org, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	christian.loehle@arm.com, tj@kernel.org, kernel-dev@igalia.com, 
	linux-pm@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 6:17=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Changwoo,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on amd-pstate/linux-next]
> [also build test WARNING on amd-pstate/bleeding-edge linus/master v6.18-r=
c1 next-20251014]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Changwoo-Min/PM-EM=
-Assign-a-unique-ID-when-creating-a-performance-domain/20251014-082420
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git=
 linux-next
> patch link:    https://lore.kernel.org/r/20251014001055.772422-9-changwoo=
%40igalia.com
> patch subject: [PATCH v5 08/10] PM: EM: Implement em_notify_pd_deleted()
> config: i386-buildonly-randconfig-004-20251015 (https://download.01.org/0=
day-ci/archive/20251015/202510151223.THlBK6QR-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0=
227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251015/202510151223.THlBK6QR-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510151223.THlBK6QR-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> kernel/power/em_netlink.c:228:6: warning: variable 'ret' set but not u=
sed [-Wunused-but-set-variable]
>      228 |         int ret =3D -EMSGSIZE;
>          |             ^
>    1 warning generated.
>

Please update the patch to address this report and resend it, thanks!

> vim +/ret +228 kernel/power/em_netlink.c
>
>    224
>    225  void em_notify_pd_deleted(const struct em_perf_domain *pd)
>    226  {
>    227          struct sk_buff *msg;
>  > 228          int ret =3D -EMSGSIZE;
>    229          void *hdr;
>    230          int msg_sz;
>    231
>    232          if (!genl_has_listeners(&em_nl_family, &init_net, EM_NLGR=
P_EVENT))
>    233                  return;
>    234
>    235          msg_sz =3D __em_notify_pd_deleted_size(pd);
>    236
>    237          msg =3D genlmsg_new(msg_sz, GFP_KERNEL);
>    238          if (!msg)
>    239                  return;
>    240
>    241          hdr =3D genlmsg_put(msg, 0, 0, &em_nl_family, 0, EM_CMD_P=
D_DELETED);
>    242          if (!hdr)
>    243                  goto out_free_msg;
>    244
>    245          if (nla_put_u32(msg, EM_A_PD_TABLE_PD_ID, pd->id)) {
>    246                  ret =3D -EMSGSIZE;
>    247                  goto out_free_msg;
>    248          }
>    249
>    250          genlmsg_end(msg, hdr);
>    251
>    252          genlmsg_multicast(&em_nl_family, msg, 0, EM_NLGRP_EVENT, =
GFP_KERNEL);
>    253
>    254          return;
>    255
>    256  out_free_msg:
>    257          nlmsg_free(msg);
>    258          return;
>    259  }
>    260
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

