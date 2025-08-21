Return-Path: <linux-pm+bounces-32806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C944B2F6C4
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 13:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFDCAA53B4
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 11:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32853310623;
	Thu, 21 Aug 2025 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdrsYZhj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF752367AE;
	Thu, 21 Aug 2025 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775669; cv=none; b=fWZG9rkLk/hBiGAvrMYrGtSGq4pNIiYCibWXAi+q98ZxN2jSlrymqFQYmNjfsuas2D7t/hx/2inyXP76Bu7lBvdLsVXRxfjqq7v4LAbiwwA2mPUVVntpYTZpMVnlQoEi4/a/U+qypF0U6xS/YdgnrHVtT9yYhd6kMARumbo06m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775669; c=relaxed/simple;
	bh=VVtwZsEvtcNcVfpXD8V0dKJU+F8T2z9T6VHTjqC4nbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bv+8/C3YBG+YiTrPaDhmIRrUYLkFOiholrINPQ5UxJvzlqoYMV1/633Z7v/Nd9meFn0O5xtb04lazH3rImdvnleaSNvGazr13CQgzGbLjYB+1PhGgzjOzDh6BsL82v4qb8tGT2TA9wbDAhAkAHD+4BOjc4bOWhp8ervGlWgIKj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdrsYZhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F30C4CEED;
	Thu, 21 Aug 2025 11:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755775668;
	bh=VVtwZsEvtcNcVfpXD8V0dKJU+F8T2z9T6VHTjqC4nbI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RdrsYZhjJ7XRTZ+DrppmDIFpgMCOmoO4tD64jVIEiSg6sjOGAucsmsWWj7IM9z3jf
	 V+uq4AnguBymaOPFaZuCTlKwRfM5gseXSS8yw90iPKawEKj5o+tiGLEcHjSsqeNF38
	 suoe3E8nBpnVyVGwRGgf6QzbXK/7KNy1aWvMPRgWz2Ri0BhNUQkAniKUwKLlbnOIH/
	 rJC3lEuTt/tAS/iDkInzMnvQrF5ULn8vgLDO4vlA+3YbeVQ2ROYoIs3YnpAIxcK+Ut
	 YrWhbChEzi1JjisYu7t0BvaVJyxKhoODBBt62TfNZx6ifMQsYC8RvP464aySD6M1T+
	 R+1Xey9HCX9FA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-30ccec59b4bso759360fac.3;
        Thu, 21 Aug 2025 04:27:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtXPtVxY10PkDo9S0QHXT7Scwlvz254AHKs6thCZV4s+1GaasMncu4uHwBqSoEAYC0g86NNlvPJfY=@vger.kernel.org, AJvYcCVa7ISU/VH4Vd7IMPlZ9fDLuack8vc8q55Z4lSJY0pMm/53eSxsE7a2/UVFlci/n079g9OIHZw85IxljV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpLfp/V0/jULRSuHnH8uBiq9xGYYGf0LwzTEBGEFxo8KDIDkB/
	mef0sXV6RhwVWz/1ULLSr+ErDbaxyEhGbYsETYX/44n9x/YtyZBt+/S4r1vmlCtuTFHPlLMfSkj
	JDwlWP+6r0uM2mVUwdDgBQS7gOyaEJUM=
X-Google-Smtp-Source: AGHT+IFxc7786NYNiS/oWBRBCoXVr1dRJvbzkJt5Qy+a/MP5Frxx50eaelNqUT/Xj2QhWS9QbyBsH0NjgOM9SFTHSb8=
X-Received: by 2002:a05:6870:1f19:b0:30b:dd94:bfb3 with SMTP id
 586e51a60fabf-314c650047cmr852801fac.25.1755775668204; Thu, 21 Aug 2025
 04:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810233347.81957-1-changwoo@igalia.com>
In-Reply-To: <20250810233347.81957-1-changwoo@igalia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Aug 2025 13:27:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ibEHC+Ckgisr+VAU=B21MgKJz2=QqGH2hd6UjUFutMSg@mail.gmail.com>
X-Gm-Features: Ac12FXwg695sYfTcYMZjBL8MGDcE1_Rv35W6sdWpJOKwqwNkEYP4sY2a3wGeOCM
Message-ID: <CAJZ5v0ibEHC+Ckgisr+VAU=B21MgKJz2=QqGH2hd6UjUFutMSg@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 00/10] PM: EM: Add netlink support for the
 energy model.
To: Changwoo Min <changwoo@igalia.com>, lukasz.luba@arm.com
Cc: len.brown@intel.com, pavel@kernel.org, christian.loehle@arm.com, 
	tj@kernel.org, kernel-dev@igalia.com, linux-pm@vger.kernel.org, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 11, 2025 at 1:34=E2=80=AFAM Changwoo Min <changwoo@igalia.com> =
wrote:
>
> Just rebased on Linus's master and resend it for review.
>
> There is a need to access the energy model from the userspace. One such
> example is the sched_ext schedulers [1]. The userspace part of the
> sched_ext schedules could feed the (post-processed) energy-model
> information to the BPF part of the scheduler.
>
> Currently, debugfs is the only way to read the energy model from userspac=
e;
> however, it lacks proper notification mechanisms when a performance domai=
n
> and its associated energy model change.
>
> This patch set introduces a generic netlink for the energy model, as
> discussed in [2]. It allows a userspace program to read the performance
> domain and its energy model. It notifies the userspace program when a
> performance domain is created or deleted or its energy model is updated
> through a multicast interface.
>
> Specifically, it supports two commands:
>   - EM_CMD_GET_PDS: Get the list of information for all performance
>     domains.
>   - EM_CMD_GET_PD_TABLE: Get the energy model table of a performance
>     domain.
>
> Also, it supports three notification events:
>   - EM_CMD_PD_CREATED: When a performance domain is created.
>   - EM_CMD_PD_DELETED: When a performance domain is deleted.
>   - EM_CMD_PD_UPDATED: When the energy model table of a performance domai=
n
>     is updated.
>
> This can be tested using the tool, tools/net/ynl/pyynl/cli.py, for exampl=
e,
> with the following commands:
>
>   $> tools/net/ynl/pyynl/cli.py \
>      --spec Documentation/netlink/specs/em.yaml \
>      --do get-pds
>   $> tools/net/ynl/pyynl/cli.py \
>      --spec Documentation/netlink/specs/em.yaml \
>      --do get-pd-table --json '{"pd-id": 0}'
>   $> tools/net/ynl/pyynl/cli.py \
>      --spec Documentation/netlink/specs/em.yaml \
>      --subscribe event  --sleep 10
>
> [1] https://lwn.net/Articles/922405/
> [2] https://lore.kernel.org/lkml/a82423bc-8c38-4d57-93da-c4f20011cc92@arm=
.com/
> [3] https://lore.kernel.org/lkml/202506140306.tuIoz8rN-lkp@intel.com/#t
>
> ChangeLog v2 -> v3:
>   - Properly initialize a return variable in
>     em_notify_pd_created/updated() at an error path (09/10), reported by
>     the kernel test robot [3].
>   - Remove redundant initialization of a return variable in
>     em_notify_pd_deleted() at an error path (08/10).
>
> ChangeLog v1 -> v2:
>   - Use YNL to generate boilerplate code. Overhaul the naming conventions
>     (command, event, notification, attribute) to follow the typical
>     conventions of other YNL-based netlink implementations.
>   - Calculate the exact message size instead of using NLMSG_GOODSIZE
>     when allocating a message (genlmsg_new). This avoids the reallocation
>     of a message.
>   - Remove an unnecessary function, em_netlink_exit(), and initialize the
>     netlink (em_netlink_init) at em_netlink.c without touching energy_mod=
el.c.
>
> CC: Lukasz Luba <lukasz.luba@arm.com>
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> CC: Tejun Heo <tj@kernel.org>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
>
> Changwoo Min (10):
>   PM: EM: Add em.yaml and autogen files.
>   PM: EM: Add a skeleton code for netlink notification.
>   PM: EM: Assign a unique ID when creating a performance domain.
>   PM: EM: Expose the ID of a performance domain via debugfs.
>   PM: EM: Add an iterator and accessor for the performance domain.
>   PM: EM: Implement em_nl_get_pds_doit().
>   PM: EM: Implement em_nl_get_pd_table_doit().
>   PM: EM: Implement em_notify_pd_deleted().
>   PM: EM: Implement em_notify_pd_created/updated().
>   PM: EM: Notify an event when the performance domain changes.

I've done a high-level review of this and it looks reasonable to me
overall, but I'd like to get some feedback from Lukasz on it.

My two requests for now are: please reorder the series, so patches
[3-5] go first, and remove the ending period (".") from all of the
patch subjects.

Thanks!

