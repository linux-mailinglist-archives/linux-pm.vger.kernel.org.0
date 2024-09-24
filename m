Return-Path: <linux-pm+bounces-14621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA44A984927
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 18:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF30C284FBA
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 16:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBF61AE869;
	Tue, 24 Sep 2024 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZX6fTKzv"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8811AC441;
	Tue, 24 Sep 2024 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193937; cv=none; b=qrLnjxPBiRoGxGQKB8ty2CODtwRv+6vye+H8ga/7rZ5mX7Mepzi3stBFoXDDx6SOsbyw3+yXlyN0dUSSNUqCC5sXtCwd6DJsuFzUqULTH/x5ru0EPKUI3gQ+5Q3fdLcaxWsOVqct8uHDcEBFxL8IYZh+FAbYkNofEARPaORCr0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193937; c=relaxed/simple;
	bh=LX+diJ7M2E4ujM5KwD7j5MZK13pg812LqbEv4+Py5+k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMqiltJ67o6d1dr/0pUfjncbBodklV1Z6SrHC0/eAvX/seAH5Xh19HRVVjfF9eSJFgYTlJyDuflcbSwIHgcTNVUptw+2tgKN0X2slFMh1UpKgQAhwu5nNvoP+veoKJmdskRgtKqONtwst3MiS3goDT+Fg/FbPuGrx6uXQ5CBhQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZX6fTKzv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=fzYnC4u4lNGhcwCgM7TOwvzsrVSzF8ITtilKodkz3e8=; b=ZX6fTKzvyEA8QYmx7dUTkaJMAy
	5df3gPxb5cygJ6usVrdkU4capeNIp4NSlmxAfWGlsG+an3hvPWeb38rs2niWeHtBiAr1pSWFlb5/E
	lc/6oyKSHtAn5+7KtX2jOxn/FY0pqQ7aA1bJNGgZBhRYN1VzcVNvLuhgs5ux0GcfEmq2HrQRRm8oR
	RXHRj2Rhp1Cz7n5lAxbtHvp5IURj710YHzlESIJfy36+1cnUOTYy+8JmgPn/D0V+amHYa6zZfMbTU
	96vIiWLm+7Q+jBuuX/zupgK/MYbGdrnRZphT9NfkLnYxKfyikIPF9GHKuGTh8DS2JHaomICbNC3NF
	/CxM4WSg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1st82M-00000001rIa-31Pi;
	Tue, 24 Sep 2024 16:05:18 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1st82K-0000000HMiS-1tTE;
	Tue, 24 Sep 2024 17:05:12 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 3/6] KVM: arm64: Add support for PSCI v1.2 and v1.3
Date: Tue, 24 Sep 2024 17:05:09 +0100
Message-ID: <20240924160512.4138879-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240924160512.4138879-1-dwmw2@infradead.org>
References: <20240924160512.4138879-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/arm64/kvm/hypercalls.c | 2 ++
 arch/arm64/kvm/psci.c       | 6 +++++-
 include/kvm/arm_psci.h      | 4 +++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 5763d979d8ca..9c6267ca2b82 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -575,6 +575,8 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		case KVM_ARM_PSCI_0_2:
 		case KVM_ARM_PSCI_1_0:
 		case KVM_ARM_PSCI_1_1:
+		case KVM_ARM_PSCI_1_2:
+		case KVM_ARM_PSCI_1_3:
 			if (!wants_02)
 				return -EINVAL;
 			vcpu->kvm->arch.psci_version = val;
diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
index fd0f82464f7d..5177dda5a411 100644
--- a/arch/arm64/kvm/psci.c
+++ b/arch/arm64/kvm/psci.c
@@ -328,7 +328,7 @@ static int kvm_psci_1_x_call(struct kvm_vcpu *vcpu, u32 minor)
 
 	switch(psci_fn) {
 	case PSCI_0_2_FN_PSCI_VERSION:
-		val = minor == 0 ? KVM_ARM_PSCI_1_0 : KVM_ARM_PSCI_1_1;
+		val = PSCI_VERSION(1, minor);
 		break;
 	case PSCI_1_0_FN_PSCI_FEATURES:
 		arg = smccc_get_arg1(vcpu);
@@ -486,6 +486,10 @@ int kvm_psci_call(struct kvm_vcpu *vcpu)
 	}
 
 	switch (version) {
+	case KVM_ARM_PSCI_1_3:
+		return kvm_psci_1_x_call(vcpu, 3);
+	case KVM_ARM_PSCI_1_2:
+		return kvm_psci_1_x_call(vcpu, 2);
 	case KVM_ARM_PSCI_1_1:
 		return kvm_psci_1_x_call(vcpu, 1);
 	case KVM_ARM_PSCI_1_0:
diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
index e8fb624013d1..cbaec804eb83 100644
--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -14,8 +14,10 @@
 #define KVM_ARM_PSCI_0_2	PSCI_VERSION(0, 2)
 #define KVM_ARM_PSCI_1_0	PSCI_VERSION(1, 0)
 #define KVM_ARM_PSCI_1_1	PSCI_VERSION(1, 1)
+#define KVM_ARM_PSCI_1_2	PSCI_VERSION(1, 2)
+#define KVM_ARM_PSCI_1_3	PSCI_VERSION(1, 3)
 
-#define KVM_ARM_PSCI_LATEST	KVM_ARM_PSCI_1_1
+#define KVM_ARM_PSCI_LATEST	KVM_ARM_PSCI_1_3
 
 static inline int kvm_psci_version(struct kvm_vcpu *vcpu)
 {
-- 
2.44.0


