Return-Path: <linux-pm+bounces-34926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D098FB822CE
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 00:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B363BEE2C
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 22:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FCE30F950;
	Wed, 17 Sep 2025 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xScshUvX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2432230F92C
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148822; cv=none; b=qTPCexp6rl3t6GzJN992D0hlHxHVj8OsKtQn9yh87tTS84KeCH49g+9jUE0C68L5B05i65IsX3QptHmCJ3DfoNCp7Zj9YLAAkTYGbsKg/xtw8a4Xoe1wUHWqS92bpqqMu9AAH1FhccCrO/ZnmHEupZwyxE5axXBxcDE6eCf19RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148822; c=relaxed/simple;
	bh=WSfFooN5Bw7kAHcBSRwXJG4k3j5I4pDgZn1B6oXDRa0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MKAj5hMcleF89/jfPwkGcG03ATP0Q6b0yN6Mn7LUhgWKrT2hQT4sCvbsICvmEgfR/7cSO70VicA9sLpSz9t365UxkYENZcG+y6TmAbapXwQoYL1gNLVrA2IYzB4+rboEoWAcc08clN/UT5N6LPu6wfbcdcq7694/+sT5ovV6U2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xScshUvX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b54fe1d849aso286866a12.2
        for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 15:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758148820; x=1758753620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2gITbjAhZLVDTe91+pv60FMHVz/PyRihO/dG6TrQ1g=;
        b=xScshUvXozX1uxER7qZsO8p7Ucy0JMRPftF2Qc4iW+jUzt2v+z7shzzTO01oxCZEkq
         051hR+Gj4XdNfQu3CBsi2wZ/EH6w9tdtqjod+Kc1XRG0O89bnsuI7loyoUxiUnZGJjMe
         RCcV2iaR48KpLhO0wVK0FVGOFqVC0u6SHuSflHNj9mda6XvYExKSVhsTN67EiEq1Idi5
         0xmZ5a+QInviQ7LhmASPABrbGQyWowkK6Dj7GE/ISc3Z7Thrvt6udxsJEK7A9GUwwmqc
         SYYllHDx/tEr61hZr1eAqBMi0W5M25jIPqfsNYUNmR3C0R2D5r1NtYnjirXfnjWeOKcx
         cHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758148820; x=1758753620;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m2gITbjAhZLVDTe91+pv60FMHVz/PyRihO/dG6TrQ1g=;
        b=Cl36Zg/8gaS5evWHO/9rPTpdEcbqyhexk41NXxZ0v/ibxI/Q+YePE88R+F2wkiGrtm
         HQsw43AzqWtfAdawR3l7cAqeFkJqFi5NDzMbOYf/RGyrNEWd8F4PlJ41XtwwYt3qeBlG
         nZKtDkOXndZwr5Dhl78JmS/cJMEVSULYKSzfYrpb0UFp8/VH8iy5xVX3IYDjoNtqUyRx
         v9i1m77PblSWoLXTSwfTmDI+OL1Wz2bGydRC42izPIYMgOoxDKwb845pZTe8PIglV5+c
         ttxCzo8FfVb/VGQtwQ4sBiG3Ep5GWhZMUKJzlr3MYq2ne8Vanfpl46lDyhxztw7HGtfm
         BPqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxUaMZItXHYj5Q2AZhWB/E793fEsX+4UOL/+ueT5vT2xaLnHUCojYBUGhiR90qhUwpbAcj6/AyuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHnqRrR4Glw5bjv3WvEanmECkFc8k2QkAHkqoANX4v4g9NPuBp
	cPRqF151Nh4AYEaaQ4Ws+8oCm4Pjs8q4Kie7qbRdjWSHDlf1NIgQCIhwzKIa07BN4jQpJiCRoAh
	FAVTmaQ==
X-Google-Smtp-Source: AGHT+IFI0s+9qm/ZBuqtuCHVVai9MRluhJYduJgd1o773c0GWF5zKPkcHTokW+JlTa7DRlVZN5DukGxMcIA=
X-Received: from pjzz6.prod.google.com ([2002:a17:90b:58e6:b0:327:e172:e96])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e082:b0:262:8bce:33bd
 with SMTP id adf61e73a8af0-27aa12ef6ffmr5224302637.28.1758148820303; Wed, 17
 Sep 2025 15:40:20 -0700 (PDT)
Date: Wed, 17 Sep 2025 15:40:18 -0700
In-Reply-To: <f533d3a4-183e-4b3d-9b3a-95defb1876e0@zytor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909182828.1542362-1-xin@zytor.com> <aMLakCwFW1YEWFG4@google.com>
 <0387b08a-a8b0-4632-abfc-6b8189ded6b4@linux.intel.com> <aMmkZlWl4TiS2qm8@google.com>
 <f533d3a4-183e-4b3d-9b3a-95defb1876e0@zytor.com>
Message-ID: <aMs40gVA4DAHex6A@google.com>
Subject: Re: [RFC PATCH v1 0/5] x86/boot, KVM: Move VMXON/VMXOFF handling from
 KVM to CPU lifecycle
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-pm@vger.kernel.org, pbonzini@redhat.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	pavel@kernel.org, brgerst@gmail.com, david.kaplan@amd.com, 
	peterz@infradead.org, andrew.cooper3@citrix.com, kprateek.nayak@amd.com, 
	chao.gao@intel.com, rick.p.edgecombe@intel.com, dan.j.williams@intel.com, 
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025, Xin Li wrote:
> On 9/16/2025 10:54 AM, Sean Christopherson wrote:
> > On Thu, Sep 11, 2025, Arjan van de Ven wrote:
> > > Hi,
> > > > I also want to keep the code as a module, both to avoid doing VMXON=
 unconditionally,
> > >=20
> > > can you expand on what the problem is with having VMXON unconditional=
ly enabled?
> >=20
> > Unlike say EFER.SVME, VMXON fundamentally changes CPU behavior.  E.g. b=
locks INIT,
> > activates VMCS caches (which aren't cleared by VMXOFF on pre-SPR CPUs, =
and AFAIK
> > Intel hasn't even publicly committed to that behavior for SPR+), restri=
cts allowed
> > CR0 and CR4 values, raises questions about ucode patch updates, trigger=
s unique
> > flows in SMI/RSM, prevents Intel PT from tracing on certain CPUs, and p=
robably a
> > few other things I'm forgetting.
>=20
> Regarding Intel PT, if VMXON/VMXOFF are moved to CPU startup/shutdown, as
> Intel PT is initialized during arch_initcall() stage, entering and leavin=
g
> VMX operation no longer happen while Intel PT is _active_, thus
> intel_pt_handle_vmx() no longer needs to "handles" VMX state transitions.

The issue isn't handling transitions, it's that some CPUs don't support Int=
el PT
post-VMXON:

  If bit 14 is read as 1, Intel=C2=AE Processor Trace (Intel PT) can be use=
d in VMX
  operation. If the processor supports Intel PT but does not allow it to be=
 used
  in VMX operation, execution of VMXON clears IA32_RTIT_CTL.TraceEn (see
  =E2=80=9CVMXON=E2=80=94Enter VMX Operation=E2=80=9D in Chapter 32); any a=
ttempt to write IA32_RTIT_CTL
  while in VMX operation (including VMX root operation) causes a general-pr=
otection
  exception.

And again, unconditionally doing VMXON is a minor objection in all of this.

