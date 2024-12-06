Return-Path: <linux-pm+bounces-18710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BED9E7639
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 17:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A3E1889E0F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 16:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569D11FFC78;
	Fri,  6 Dec 2024 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NU6NuoZy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A8A1FFC6C
	for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2024 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502884; cv=none; b=cdAZ3f+i95UDKKeRka2L9DB77AGEIR5q2s9UDJFkgWmAcVYjFxS/D4p2Bd3N4r1712UzDWwtEqlTFkaeEhu8O7N/uF0MB8DBwHdK+KujHlBIlj5gK6vM17EigDH/dLAm2IFCTFUtUR5YpNZBirGL4FYi/8sQ2qHBA7XT4UPqW+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502884; c=relaxed/simple;
	bh=X/j7a1AVVEbEIsus9GgwJm7rtls7Wp7Nn7vlOuWizNM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YDIcU1WrKpnt4hZjcANqdDIrI5iqANL2xYNJLVEECS8cO7POhFG3qUJoRtJ+l4Nzfpe7Vu2M4UaxXJl3OmBp4HQtbzKKVmcWcE9n+T8txk7u7ekfdI3g6bnR2AD2+ZSpHOoy8VtKDPaa/fPOggs3esLWgSDBXlpOII22k4g7s+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NU6NuoZy; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fd1d9a70f3so1175687a12.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2024 08:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733502882; x=1734107682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gdOhbbudcsT18ChsyehuzpKH7u9A/Whi1QSUHUKo4+Y=;
        b=NU6NuoZy9DCICJreU2FW58c/e/w/TZyvMtChADpm9jA4S9h21xuRmsV5qNyC3WVoiO
         zlI7km9E89b0bnxDxU9Am1c+xjhlqqfhNn8biSw8csTuWOi0b2JYtlip/LLz+B9DZ5lI
         Bb2gesgKgwwQnH2xhkcrLJbe3R39wDGc+dgyOY/rBxl6ANqtudoFb9e4imyUO8YMv5/Z
         AIscqjyLSU/jo935utTZYyIJvir/IqiFjknmeWffWDTZL1J7516KG1EIGgDGISGVqaK3
         Uy0Z00kZ03FOIzu5p/R3mx8r8JVhBSv8uTmv9oGhYZoYKj499iQ7eWnvmU9PCpuwjilw
         xamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733502882; x=1734107682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdOhbbudcsT18ChsyehuzpKH7u9A/Whi1QSUHUKo4+Y=;
        b=VsrHgAa37AJY6nOlz3ETZPq4xLLo1esIdgzRNHYUmDxoI7G5zS2p3dHp+gpcamTEsa
         UHpsBphFSDpfaMNuph6XhyONLQSYr/Rxql9xbbgwirc7Ys+973e9372abC8GFFzQWlru
         4UA9rV+bEz7FxeV1NK5ST8onFQHE8fieLCrKkm79nFGqsBIMgV48sJ7NlMQE/ea3y5EA
         Svv/loX69MIFUqTor9rLDAVFSiDUbn6nHgsrEcJQCZn6qjiHRHyC+vGvfXC3y3zjWodP
         aMVZjt+VBbHTLhgPfKl2PvQtxu0NGAOIsouew0DriLN6tBqL04YHS/Q0UzDTRjHc/sBH
         JlIg==
X-Forwarded-Encrypted: i=1; AJvYcCWXRa/dB2L5QUoaskmveTeWt8j0Pt436Z76EDHUKd9j2U9/aW1RFGT+T/b++OLCHcLjG8Tp20cKgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwI9jp9Rhg0xL8f1eR82VZW4TKNqbrXLrGsQ5SHGiOR9Kxc739R
	91k3vspbjLwi361VEi2tiYduu8w0+6hnLvDJoMDbN1HI6oBLEMI2UtcRxD9Dw1yDaprz0i3cibk
	OVQ==
X-Google-Smtp-Source: AGHT+IEjRw7QnXc1P/zcq6HHCb1Idg91IQ175oHpS+xymlvayAU568Tah/7yfMxhEt8DbssELS7lXeZX1d0=
X-Received: from pgct14.prod.google.com ([2002:a05:6a02:528e:b0:7fd:113b:ea45])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:114f:b0:1e0:c56f:7daf
 with SMTP id adf61e73a8af0-1e1870a8df8mr5765535637.6.1733502882145; Fri, 06
 Dec 2024 08:34:42 -0800 (PST)
Date: Fri, 6 Dec 2024 08:34:41 -0800
In-Reply-To: <CALMp9eRqHkiZMMJ2MDXOHPbGx1rE9n5R2aR-F=qkuGo0BPS=og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com> <Z0-R-_GPWu-iVAYM@google.com>
 <CALMp9eTCe1-ZA47kcktTQ4WZ=GUbg8x3HpBd0Rf9Yx_pDFkkNg@mail.gmail.com>
 <Z0-3bc1reu1slCtL@google.com> <CALMp9eRqHkiZMMJ2MDXOHPbGx1rE9n5R2aR-F=qkuGo0BPS=og@mail.gmail.com>
Message-ID: <Z1MnoQcYpzE-4EZy@google.com>
Subject: Re: [RFC PATCH 00/22] KVM: x86: Virtualize IA32_APERF and IA32_MPERF MSRs
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Mingwei Zhang <mizhang@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Perry Yuan <perry.yuan@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Dec 04, 2024, Jim Mattson wrote:
> Wherever the context-switching happens, I contend that there is no
> "clean" virtualization of APERF. If it comes down to just a question
> of VM-entry/VM-exit or vcpu_load()/vcpu_put(), we can collect some
> performance numbers and try to come to a consensus, but if you're
> fundamentally opposed to virtualizing APERF, because it's messy, then
> I don't see any point in pursuing this further.

I'm not fundamentally opposed to virtualizing the feature.  My complaints with
the series are that it doesn't provide sufficient information to make it feasible
for reviewers to provide useful feedback.  The history you provided is a great
start, but that's still largely just background information.  For a feature as
messy and subjective as APERF/MPERF, I think we need at least the following:

  1. What use cases are being targeted (e.g. because targeting only SoH would
     allow for a different implementation).
  2. The exact requirements, especially with respect to host usage.  And the
     the motivation behind those requirements.
  3. The high level design choices, and what, if any, alternatives were considered.
  4. Basic rules of thumb for what is/isn't accounted in APERF/MPERF, so that it's
     feasible to actually maintain support long-term.

E.g. does the host need to retain access to APERF/MPERF at all times?  If so, why?
Do we care about host kernel accesses, e.g. in the scheduler, or just userspace
accesses, e.g. turbostat?

What information is the host intended to see?  E.g. should APERF and MPERF stop
when transitioning to the guest?  If not, what are the intended semantics for the
host's view when running VMs with HLT-exiting disabled?  If the host's view of
APERF and MPREF account guest time, how does that mesh with upcoming mediated PMU,
where the host is disallowed from observing the guest?

Is there a plan for supporting VMs with a different TSC frequency than the host?
How will live migration work, without generating too much slop/skew between MPERF
and GUEST_TSC?

I don't expect the series to answer every possible question upfront, but the RFC
provided _nothing_, just a "here's what we implemented, please review".

