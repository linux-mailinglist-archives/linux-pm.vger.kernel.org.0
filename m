Return-Path: <linux-pm+bounces-34747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4362CB59FD5
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 19:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233F646730D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 17:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589C92857E0;
	Tue, 16 Sep 2025 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DYjTiYHR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D077A271469
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045398; cv=none; b=Hi+eeuEX3U+HKmcwvFkRDXDGH2+PGZitQOHnzeTbUpOBw02GiIa+HrmYzkoEyGCP2gfTOevwaOJg3DuhFhXSeCHERD+vtilWX+pLCsJSL0/GwK5nMgflF5dOyczs5uaVIDVOSsK2StFpySePLIpCeRvmZFXbftydWc3ZziDWAcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045398; c=relaxed/simple;
	bh=MSicL3mF2LDPj9K1Dr5cIfPilYm5d1g/0kAnPclSKn4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IAeKE2jTyrnhtKG4ljaK+y8MXRZGLey8tZSepDpZzE+juHzfneE1Hsh0uErUR2n6EKKWFJJOS0Y12h1BI6MwkPKcE34QtnkhJv8JruznRPJkqkXv0Rrexmmwhsjsj98naSJMY1X0vegGbunwqOCm5QQcuKN/048w9FvUSz/MDdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DYjTiYHR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24ced7cfa07so59903765ad.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758045396; x=1758650196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T8se0Qtiueaxkhq1BXHRNd0a/VQqDJMZQCkyk1YyNA8=;
        b=DYjTiYHRoIam6SNbmhqy3xJpy57sCL3HpOUt/uxPTzycIlPqQkEz03Iiki2Cn2px3z
         QR+dIYJCh0S5RsGsY4X0v36d0DZysD5nWUzPrDp5cJL5y8042oyBanQKO/rlPP+fcHJr
         MF0WfG6JVImQzRuf27LbnN2HZjdM8ihbWABX6nGxaZWkBWVGCsMtBGMOiGO0cUjQO194
         6RFLOkD4eFsOXfd2n5sK1VcysXBHSNJA5QC9WxgVNQ9aU3jU8dEycz4+s1f5naUtSLjP
         6ztAmr1vP78AAeDOgmGd0hEjEYq7Dg59RsanUmhNQGrHxYulg6CFHYnZNyZ/asYfmQQj
         ZjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758045396; x=1758650196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8se0Qtiueaxkhq1BXHRNd0a/VQqDJMZQCkyk1YyNA8=;
        b=jlRl/La3IluLhuSlnhepxr6+4Kf2i4yvdMDmOtuOM1qZdso/Z6cgQNEUj4E/idCTOj
         Do12yrJfDjFP8mQT1WDq1AJNox47BaY1xa4JdzIC6xNEKzCMSSfcDS5lK7Itv4krva4R
         Ul+RgrTlilncwfU72WWc3JdNXq4wnQ76KNcJpB56GDzGW34CPsanC3jX9yB6IkQMUPIj
         Wnpt1ZtuTlfVOfghyOYq4s0oYnmQWLgrG+F41mD8YqgQG1Gl7tSiHu5vlTg92/bckXUd
         ems2ng27tlSqTbEDdxLnGxYx3RT5LM8AAue1NSFc3xNCEbyozb7LP+iyPA8BXU71kakv
         MreA==
X-Forwarded-Encrypted: i=1; AJvYcCVHJ0WUlQbuqBIw0RETnhG6WWRkhW6II4hA9BH/cBaulQvj3FKbbBh83AFhy4orYvVswmKLzlFL1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz42RlcSmOnlHL2pPmv3HKnU4kAH5zK9uCi8KfyVLtK6i9RZEZN
	0VnoqD3T7XlI9jqfYFCwSGfQRJKYhr9R1T6DG3UboJl4NifWl5FzzG5fcPmjv7MfkkLwyw3LxRV
	B7+0nmQ==
X-Google-Smtp-Source: AGHT+IHX97aKh/O5efbD/RijuE1Ev8nPZtcrQ+o4OPDVMwfBtYOs0+ySd/jGWF3rPylA60gNXsyN3zspzrA=
X-Received: from pjbst15.prod.google.com ([2002:a17:90b:1fcf:b0:327:b430:11ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d0e:b0:267:9aa5:f6a6
 with SMTP id d9443c01a7336-2679aa61619mr92516245ad.19.1758045396152; Tue, 16
 Sep 2025 10:56:36 -0700 (PDT)
Date: Tue, 16 Sep 2025 10:56:34 -0700
In-Reply-To: <20250909182828.1542362-6-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909182828.1542362-1-xin@zytor.com> <20250909182828.1542362-6-xin@zytor.com>
Message-ID: <aMmk0lUJ8gs7OBw-@google.com>
Subject: Re: [RFC PATCH v1 5/5] KVM: Remove kvm_rebooting and its references
From: Sean Christopherson <seanjc@google.com>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-pm@vger.kernel.org, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, pavel@kernel.org, brgerst@gmail.com, 
	david.kaplan@amd.com, peterz@infradead.org, andrew.cooper3@citrix.com, 
	kprateek.nayak@amd.com, arjan@linux.intel.com, chao.gao@intel.com, 
	rick.p.edgecombe@intel.com, dan.j.williams@intel.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 09, 2025, Xin Li (Intel) wrote:
> Drop kvm_rebooting and all related uses.  Virtualization is now disabled
> immediately before a CPU shuts down, eliminating any chance of executing
> virtualization instructions during reboot.

Wrong.  KVM clears EFER.SVME in reponse to kvm_shutdown(), and thus can trip
#UDs on e.g. VMRUN.

