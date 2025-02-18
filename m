Return-Path: <linux-pm+bounces-22313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46409A39E25
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 15:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695D33A13D0
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 13:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA9C2405EC;
	Tue, 18 Feb 2025 13:57:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D7A236A61
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887021; cv=none; b=eorj7IT4Q+SkxYF1LjIzcVFpcONTKoDqnNI33ehMPVkXXNdKMIl3PeR9REEXyVc/vSrMb57kVWw6M8e6SUyI6U7pzry9ltH+4JJSGRMVpbT/uU3p5Vr/f2R3Qkd32WYeur9S7qlLhW+soTxe9M7H/vBNq/F0wSAvof4vjExGpt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887021; c=relaxed/simple;
	bh=1S+sSuWNNmrqRztYrpuEloXYZYpDhHH/xVAXcq4Ir0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwxwpG82nyffm7/h72iuOKFj2ooYizAkUJrxK234J4d1DNla2MsIHtXph7GLCmGF06NO/hzLOl2e3IXTBYM/5WO3cZb7gYo8wVGs6p8CMewRDP3RCKo9WlMuJRzQrLfcJ4AjQWpTOFK1nShHf1RZgQ5xpsg82aRxYoHPDfqi8p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B57D3152B;
	Tue, 18 Feb 2025 05:57:15 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9594C3F6A8;
	Tue, 18 Feb 2025 05:56:55 -0800 (PST)
Date: Tue, 18 Feb 2025 13:56:52 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pm@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Update section for cpuidle-psci
Message-ID: <Z7SRpEE0UFHdSEmR@bogus>
References: <20250217140145.117086-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217140145.117086-1-ulf.hansson@linaro.org>

On Mon, Feb 17, 2025 at 03:01:45PM +0100, Ulf Hansson wrote:
> Add myself as a co-maintainer for the cpuidle-psci driver and the
> corresponding git-tree, which I am already using for this.
>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

