Return-Path: <linux-pm+bounces-43684-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ONMIAyYqWlKAgEAu9opvQ
	(envelope-from <linux-pm+bounces-43684-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 15:49:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C971213D5C
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 15:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6642F30F62CD
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 14:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D9F3AE187;
	Thu,  5 Mar 2026 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbNAcvQ7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9773ACA74
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721740; cv=none; b=nYHPHk0goVmDaFCZmv3L2PxivtRrhRuxAnQnjmF+skifPGPw5M5MHCFIBwgdXvpZ+1Tx4Op4/mIV7DQVXT1qzGYRJT0MrMMvYb2UXv8Hi1uGSg8IqCfZGch4yu79pu/yTNG9X3ziW8nbm+ih9L2G93ZpIlskkeCmy0ArjCmE/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721740; c=relaxed/simple;
	bh=w6XvGW5Stu4dvffYOrtvNHkfdROlqzsFvMiQSuCyn8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLPk1UdQq2wTYS3f4C2GzOeJ70v1k++uHV+clYmDZdHwvEU/vDESawEgX1N5fZK4oqPKuQQh7dhqwOUSdBEVATwocG1xOpIxkrcOHVPjmZQ2sdjjgd6/M8ucWP6bg9emjWnOA3AIC2Zj6F42QYdjXhJkTRyvER2SI7SFHCVGLx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbNAcvQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE76C19423
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 14:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772721740;
	bh=w6XvGW5Stu4dvffYOrtvNHkfdROlqzsFvMiQSuCyn8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NbNAcvQ7kPpxZoPq1w+BhzfXSwbtKaNlSroextmp8BmI0Y5AazkxjTXvrIKxwMmOA
	 WXBJ5AVGvGmXAJ8U8J6jc7nvOi+ggWBXCEhg6/AmaLQiT2961eIV0o2GHsOW9sMjUR
	 L8iw+rAzmUJ8RcS/9rFCXVU6OVKyE7/gF7jB0kQ7wITJShB6zXNVeJXkSRlIKGjHaq
	 ayGfUW+TpTcD2LX1OMA4LkDzUIvczE2+3Rb9LXwLm2I2xjtbNjzarVkxOJMUBsQRzn
	 +Tud0qTzsxPYHkvmDVu+aVy3SlIFwbNHtPQpoH5lR0VUXRc8q1s8UqiwmA5UZSk2BZ
	 kwU3HGWCE2Scg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40ea611d1a4so1271670fac.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 06:42:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX0jMpK6sFPj8uzgnbgFgEHlTCu0WnZ5dBmYeoyawmDH6e7aQanB7BeqgSg1nPbfKN2ZbwAOnu5Eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqPMguldo0Qa+CefMlgurD5e5RISi0jPqBSNzm+d8uYQsAZ57E
	RoASGkeX86Cv64idF/cOxXeD0BpG5ZvvBuH1erUqlL6DZ4jj9s/m+ANEzPrgX0eCogpyXAfNi+9
	bS+La2tiWjglMbZu7bCAd/kEf4rGF4aQ=
X-Received: by 2002:a05:6870:ad09:b0:3e8:983c:c8a with SMTP id
 586e51a60fabf-416abb3d153mr3859578fac.37.1772721739436; Thu, 05 Mar 2026
 06:42:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223190420.874853-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20260223190420.874853-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Mar 2026 15:42:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ju7V3EaUgwxpUZV2LN2YBaduEd4hpoOJsL-LRmSJ1pvA@mail.gmail.com>
X-Gm-Features: AaiRm50mPtFS9bdvsp6P7AGSOJPMn_J8WMWzSSwvA8CYPtHkJEg3f7x7Dqh689s
Message-ID: <CAJZ5v0ju7V3EaUgwxpUZV2LN2YBaduEd4hpoOJsL-LRmSJ1pvA@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: int340x: Read DDR data rate for Nova Lake
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5C971213D5C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43684-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 8:05=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add support for reading DDR data rate from PCI config offset.
> The register details are:
> CFG Offset : 0xE0
> Bits       : 11:2
>
> DDR Data rate is in 33.33 MTPS units.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../int340x_thermal/processor_thermal_rfim.c     | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim=
.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> index 314fbc1f490f..2e834a175471 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> @@ -402,6 +402,11 @@ static ssize_t rfi_restriction_show(struct device *d=
ev,
>         return sysfs_emit(buf, "%llu\n", resp);
>  }
>
> + /* ddr_data_rate */
> +static const struct mmio_reg nvl_ddr_data_rate_reg =3D { 1, 0xE0, 10, 0x=
3FF, 2};
> +
> +static const struct mmio_reg *ddr_data_rate_reg;
> +
>  static ssize_t ddr_data_rate_show(struct device *dev,
>                                   struct device_attribute *attr,
>                                   char *buf)
> @@ -410,10 +415,20 @@ static ssize_t ddr_data_rate_show(struct device *de=
v,
>         u64 resp;
>         int ret;
>
> +       if (ddr_data_rate_reg) {
> +               u16 reg_val;
> +
> +               pci_read_config_word(to_pci_dev(dev), ddr_data_rate_reg->=
offset, &reg_val);
> +               resp =3D (reg_val >> ddr_data_rate_reg->shift) & ddr_data=
_rate_reg->mask;
> +               resp =3D (resp * 3333) / 100;
> +               goto ret_resp;
> +       }
> +
>         ret =3D processor_thermal_send_mbox_read_cmd(to_pci_dev(dev), id,=
 &resp);
>         if (ret)
>                 return ret;
>
> +ret_resp:
>         return sysfs_emit(buf, "%llu\n", resp);
>  }
>
> @@ -461,6 +476,7 @@ int proc_thermal_rfim_add(struct pci_dev *pdev, struc=
t proc_thermal_device *proc
>                 case PCI_DEVICE_ID_INTEL_NVL_H_THERMAL:
>                 case PCI_DEVICE_ID_INTEL_NVL_S_THERMAL:
>                         dlvr_mmio_regs_table =3D nvl_dlvr_mmio_regs;
> +                       ddr_data_rate_reg =3D &nvl_ddr_data_rate_reg;
>                         break;
>                 default:
>                         dlvr_mmio_regs_table =3D dlvr_mmio_regs;
> --

Applied as 7.1 material, but I rearranged it to avoid using goto and
declare local vars where they are needed, please see:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/patch/?=
id=3D6d3e2ce6f10107c2e5870e9dce7c2e1d03a6be72

