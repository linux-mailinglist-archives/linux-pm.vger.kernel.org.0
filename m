Return-Path: <linux-pm+bounces-26516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EC9AA64E0
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 22:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55D31BC79FF
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 20:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D23420F088;
	Thu,  1 May 2025 20:45:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6F92AD3E;
	Thu,  1 May 2025 20:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746132313; cv=none; b=NBqSq5bYbd7NPqZYsWN8F+2KtKfMSuwBHYKH06Evkgj9lisQifUWuLSb6zRY0puk289+hsel7QyeU4hgdIucxi1KrDvmjzYg/ef/rCOzgo+6qYbRrp1vO+O7aE5wm2uiQldssnYp/qqjD9AKF8iUpo9O7GrHHFg2goum18dOGLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746132313; c=relaxed/simple;
	bh=SkHAXjZq2+6VSbEyv1UkUsQpOBRQP8lTzgtiG4/lWmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Llu744B9dXb1UVSsq6dvzODN63rmlfqPuqDp++j9ZbXZlCT4jG9Yh/3+LVAKIjbHR8Arzp0JGulfufa/2/LtdyQyGrDlM5/e2okJfr0q0wKnujtkGRA17kZgFy+rFBUsux4QbCgplVKxO7N3w19zMoNox2moueoCX9ohQPDEwX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B52C4CEE3;
	Thu,  1 May 2025 20:45:12 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3744B180F5E; Thu, 01 May 2025 22:45:10 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250430055114.11469-1-clamor95@gmail.com>
References: <20250430055114.11469-1-clamor95@gmail.com>
Subject: Re: [PATCH v6 0/2] power: supply: Add support for Maxim MAX8971
 charger
Message-Id: <174613231020.58629.10397388869365937631.b4-ty@collabora.com>
Date: Thu, 01 May 2025 22:45:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 30 Apr 2025 08:51:12 +0300, Svyatoslav Ryhel wrote:
> The MAX8971 is a compact, high-frequency, high-efficiency
> switch-mode charger for a one-cell lithium-ion (Li+) battery.
> 

Applied, thanks!

[1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
      commit: c5a0a64c1222cd2bfab3ae4227caba2f1c0499f5
[2/2] power: supply: Add support for Maxim MAX8971 charger
      commit: 60cd40eee4f4f57e88bd5dd03f299eb9e17c73e5

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


