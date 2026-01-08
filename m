Return-Path: <linux-pm+bounces-40506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B81C3D06570
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 22:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CBA7303E00A
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 21:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6916E328B6C;
	Thu,  8 Jan 2026 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIWLsRRM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6521E1DFC;
	Thu,  8 Jan 2026 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767908105; cv=none; b=r8QNtsuxSx6vkJVHqIz63FskvOXnm+ndsE8+WTaeWiy3vjDJpIsKzCU2+CRdQIb4Sfn6T7kGqsvMDY2SFk/Ynk0xqJcX3jdYnDtNOqIV7DBKXxnWKr+UjqRJdLPEhtiGaj49unTotGUU8ookczmebtu2dBWOeTr8+16celEcVLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767908105; c=relaxed/simple;
	bh=/dP7HWwFiM5FLFQ5M4Vedi+Udyq6twW6yPD+bFAR6n4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SgBjkuanA4sqeLKyUc15365bD2J/+3cEmu2GAWQ6rXElEXTofHcUupeccSdCGz5SyncfnyAovflIy3gJlyNfIOYaUrYEgPh6EQgxWJQHtGVT1GWteAyGxESgu+ktcOEDPf1wKnmhkPhHCUMERP6Hvwpqs8OYFCJeKpx7HWlgVd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIWLsRRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56529C116C6;
	Thu,  8 Jan 2026 21:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767908104;
	bh=/dP7HWwFiM5FLFQ5M4Vedi+Udyq6twW6yPD+bFAR6n4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lIWLsRRMssOf8Lcw71AQ5tL5KRD3plo/gsOo0OWyGday4DLBZbI5RF3v/Zd6ii7hC
	 kRM08l/6yTu8AF0gTj+ElMvbw1YYiFDtIKehmqTMAjBEkS2LXRPdT14rQfvWrun3T/
	 CmXitgnaPQbjGsD14v565le1xTDt7hRcbjuiMWMaFAOvEpBWCXZbiGdjyFH9r4Ev9n
	 2OoQdjmt6CA8GcR4p4goYaC8kwGWDM2oBw3o4Sk3g15gRWHl0Nb2n6aKG1PEZ521AJ
	 7Zbf5Z0cGUb0KUK5wSOZHRxrJI2bv+M6oz5u9FjMIphirZN0CQk67o3hKhemGQZYLy
	 JShUzR/EUYuaA==
From: Thomas Gleixner <tglx@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson
 <ulf.hansson@linaro.org>, Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v1 01/23] genirq/chip: Change irq_chip_pm_put() return
 type to void
In-Reply-To: <4723896.LvFx2qVVIh@rafael.j.wysocki>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
 <4723896.LvFx2qVVIh@rafael.j.wysocki>
Date: Thu, 08 Jan 2026 22:35:00 +0100
Message-ID: <87y0m7ss8r.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Dec 22 2025 at 20:50, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The irq_chip_pm_put() return value is only used in __irq_do_set_handler()
> to trigger a WARN_ON() if it is negative, but doing so is not useful
> because irq_chip_pm_put() simply passes the pm_runtime_put() return value
> to its callers.
>
> Returning an error code from pm_runtime_put() merely means that it has
> not queued up a work item to check whether or not the device can be
> suspended and there are many perfectly valid situations in which that
> can happen, like after writing "on" to the devices' runtime PM "control"
> attribute in sysfs for one example.
>
> For this reason, modify irq_chip_pm_put() to discard the pm_runtime_put()
> return value, change its return type to void, and drop the WARN_ON()
> around the irq_chip_pm_put() invocation from __irq_do_set_handler().
> Also update the irq_chip_pm_put() kerneldoc comment to be more accurate.
>
> This will facilitate a planned change of the pm_runtime_put() return
> type to void in the future.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Thomas Gleixner <tglx@kernel.org>

