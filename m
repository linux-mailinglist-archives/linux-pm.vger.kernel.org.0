Return-Path: <linux-pm+bounces-36586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50891BF7D2E
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 19:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1285B19A1E23
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9597342CBD;
	Tue, 21 Oct 2025 17:07:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5564F2D0C7D;
	Tue, 21 Oct 2025 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761066429; cv=none; b=kp7R76rWJTOmhbytD92wrwh3Xdl5yLVhhk3eOQNhdAcpKXdgxh+EKa953Q0sxzCG/NCPL+v1PzaeDX6YGkPJMttuqh1lw0d5JXTollaLFZcN/gnbfT+43SxRDe9/Q2xSeAmdskURG/zw09kY/2eSfk5J6hNEEVPVO1Up/xvCmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761066429; c=relaxed/simple;
	bh=SfujZNGCUwdHXhnw5KtfoR9q5ts6/wY+0OdokUskIMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lViFY1yRE0ym/+gfMiGgH/X6WkFMDlECPZV8D2fU80kSu0496D/qOdNTde6d+vn0inN9sAdtc9xox3az9s5JwmgUZxm7J6V02RLUdy1qGUC8ys0KUnbD/XxRmo7PV0jdmeZMo0hsn31k6OJ3X1b+OGHkFwpLAdyS0OWMBwk5OCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id ACE04C05CB;
	Tue, 21 Oct 2025 17:06:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 2365B80009;
	Tue, 21 Oct 2025 17:06:53 +0000 (UTC)
Message-ID: <5e11f1bacb6430e1331f02e3e0e326a78e5b0d12.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add uninitialized pointer with __free
 attribute check
From: Joe Perches <joe@perches.com>
To: Ally Heev <allyheev@gmail.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
  Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 David Hunter <david.hunter.linux@gmail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Viresh Kumar	 <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,  linux-pm
 <linux-pm@vger.kernel.org>
Date: Tue, 21 Oct 2025 10:06:52 -0700
In-Reply-To: <20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>
References: 
	<20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2365B80009
X-Stat-Signature: rtipdxzuuspsu4ye6rx1eywenjf4xmbm
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/aK9PuxmffjsTgMj+7z4sgkWUk2J9UG3M=
X-HE-Tag: 1761066413-389271
X-HE-Meta: U2FsdGVkX180ftX0W8yiVUd9MfsrdAPQRpyGK5++Zp8ivAXNqnmopqHV64+/SigWNggHzzW7JK87cKTebQm6lUXOd7Ezd4w/lnclCGEtyolye3dNDuFfgCz3Hs4VypC2IH5Jzp8Iv1DwTdSnOiXqZXa4BChHuoGCd2iEt1m6btxx/57curR3NDrqcnDBDmPrCUxSwWUGKP22CYp8VUZGkojDiJ+CnlnKUw9YJUNopTfsA9BOoIpw4hkUN5l4XNqst3pbp/gvcYtZvMVE8qbivsDrS4bHFglsPNZn+cY8QAB0x9/lJGQVQ777+DxamNSr

On Tue, 2025-10-21 at 17:00 +0530, Ally Heev wrote:
> uninitialized pointers with __free attribute can cause undefined
> behaviour as the memory allocated to the pointer is freed
> automatically when the pointer goes out of scope.
> add check in checkpatch to detect such issues

Seems sensible.  Couple minor points below:

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7721,6 +7721,12 @@ sub process {
>  				ERROR("MISSING_SENTINEL", "missing sentinel in ID array\n" . "$here\=
n$stat\n");
>  			}
>  		}
> +
> +# check for uninitialized pointers with __free attribute
> +		if ($line =3D~ /\s*$Type\s*($Ident)\s+__free\s*\(\s*$Ident\s*\)\s*;/) =
{

The leading \s* isn't useful, but \b should be used.

Perhaps verify that $Type is a pointer as well

		if ($line =3D~ /\b($Type)\s*($Ident)\s*__free\s*\(\s*$Ident\s*\)\s*;/ &&
		    $1 =3D~ /\*\s*$/) {

to avoid things like:

drivers/net/ethernet/microsoft/mana/gdma_main.c:	cpumask_var_t cpus __free(=
free_cpumask_var);


> +			WARN("UNINITIALIZED_PTR_WITH_FREE",
> +			      "pointer '$1' with __free attribute should be initialized\n" . =
$herecurr);

			pointer '$2' etc

And this would not find uses like the below where another definition
is done before a definition with __free on the same line:

crypto/testmgr.c:       u8 *ptr, *key __free(kfree);

There are many uses in drivers/opp/ that could be updated where
the initialization is done after the definition like the below:
(I've added the opp maintainers to the cc's)

drivers/opp/core.c-unsigned long dev_pm_opp_get_max_clock_latency(struct de=
vice *dev)
drivers/opp/core.c-{
drivers/opp/core.c:     struct opp_table *opp_table __free(put_opp_table);
drivers/opp/core.c-
drivers/opp/core.c-     opp_table =3D _find_opp_table(dev);

An aside found while using grep:

There are uses of DEFINE_FREE that seem to have an unnecessary trailing ;

$ git grep -w DEFINE_FREE | grep ';'
drivers/firmware/efi/libstub/efistub.h:DEFINE_FREE(efi_pool, void *, if (_T=
) efi_bs_call(free_pool, _T));
drivers/fwctl/mlx5/main.c:DEFINE_FREE(mlx5ctl, struct mlx5ctl_dev *, if (_T=
) fwctl_put(&_T->fwctl));
drivers/pci/msi/msi.c:DEFINE_FREE(free_msi_irqs, struct pci_dev *, if (_T) =
pci_free_msi_irqs(_T));
drivers/tty/vt/vc_screen.c:DEFINE_FREE(free_page_ptr, void *, if (_T) free_=
page((unsigned long)_T));
fs/pstore/inode.c:DEFINE_FREE(pstore_private, struct pstore_private *, free=
_pstore_private(_T));
include/linux/cpumask.h:DEFINE_FREE(free_cpumask_var, struct cpumask *, if =
(_T) free_cpumask_var(_T));
include/linux/execmem.h:DEFINE_FREE(execmem, void *, if (_T) execmem_free(_=
T));
include/linux/fwctl.h:DEFINE_FREE(fwctl, struct fwctl_device *, if (_T) fwc=
tl_put(_T));
net/core/dev.h:DEFINE_FREE(netdev_unlock, struct net_device *, if (_T) netd=
ev_unlock(_T));

