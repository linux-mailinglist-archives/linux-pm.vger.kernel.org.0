Return-Path: <linux-pm+bounces-34929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3766B82397
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 01:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B006261D1
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 23:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2D930FC22;
	Wed, 17 Sep 2025 23:03:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CF7285069;
	Wed, 17 Sep 2025 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150220; cv=none; b=fpmdMbMmx6bqGX2PDBmrD/tfHLA21lSnD5IMuJtaaVkP3of90bg//p51stZ7hHS4kQJNq4Vk82KoATQH41ojHGO+eFlqB8L6RDVmx5rO+5MnPWEb6zWl0W2BHw1cQRzSPin6qpZIyKkh6l9vFzveQhPW+XaPXwoMdlahe81a6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150220; c=relaxed/simple;
	bh=A4erDhLOSZwZWdu1NH8YutKuxYifPHzwmdYZj77gSr8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NDg6iuF5s/893JBN8EDbTRUOvmc/EjeaEzEv5fn2t/w2uINKmoJ1apazgGgMYeFHP3uscuqe66H7P0gvybYO986XuXKTNGYzfRjsup1ccuSdpkKhkBMQJJTKOovgzcieolBtZlr7c35VinfcctSKhNbASG56DBPTvQk1cRvhq+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D16EC4CEE7;
	Wed, 17 Sep 2025 23:03:40 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 53E5718067D; Thu, 18 Sep 2025 01:03:38 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 "Andrew F. Davis" <afd@ti.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250909143432.121323-2-clamor95@gmail.com>
References: <20250909143432.121323-1-clamor95@gmail.com>
 <20250909143432.121323-2-clamor95@gmail.com>
Subject: Re: [PATCH v1 1/1] dt-bindings: power: supply: bq27xxx: document
 optional interrupt
Message-Id: <175815021832.129824.10659610018751144713.b4-ty@collabora.com>
Date: Thu, 18 Sep 2025 01:03:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 09 Sep 2025 17:34:32 +0300, Svyatoslav Ryhel wrote:
> Document an optional interrupt found in some controllers of BQ27xxx
> series. The pin to which the interrupt is connected is called SOC_INT or
> GPOUT.
> 
> 

Applied, thanks!

[1/1] dt-bindings: power: supply: bq27xxx: document optional interrupt
      commit: b4f7a727c29cd1fa6149a81f16408ee7c1f7de0c

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


