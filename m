Return-Path: <linux-pm+bounces-37281-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27570C29BC9
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 01:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08E718914E2
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 00:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62FD26A1AF;
	Mon,  3 Nov 2025 00:48:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D28269CE8;
	Mon,  3 Nov 2025 00:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130924; cv=none; b=ADiKWoDsFi19inTXk/NBYipA6bD0BAt3Wivl4QLm19oCw8ZTITVyA38KiD9RwVizYKM2ltpERCxFNB7NAFsqh9rb7KY04GjEQU5lBHRJJQMVNG6n5T7mYYn9RBx49Qh3sE4EZWaZY0nu7FMyUFmLSl3bnRJ7MOmO3QGnxmxUCok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130924; c=relaxed/simple;
	bh=oqMUtkg0C6dq+0OEgc827D+kqB7xcg8Gy9UecXwt6lI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jrLCwncxqNe1NvtRkDl34BF790u1Q0Fv6LDLPwirPo1iBcYUGRwwBZSxFGhDVRLj6wR7rotWndMpZibNoWjck+u6C6JySCed/RMR6RgW7oOVC1jfVmD83bAGJNKi4kXGpdmo/eFgrZuD5HfXPL69NfzaUw+ljmzAAPvMBpEWZYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AF1C4CEFB;
	Mon,  3 Nov 2025 00:48:43 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 7EB631822DB; Mon, 03 Nov 2025 01:48:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, cy_huang@richtek.com
Cc: ob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <cover.1761894605.git.cy_huang@richtek.com>
References: <cover.1761894605.git.cy_huang@richtek.com>
Subject: Re: [PATCH v4 0/3] Add Richtek RT9756 Smart-Cap divider charger
Message-Id: <176213091350.301408.12731744580465780465.b4-ty@collabora.com>
Date: Mon, 03 Nov 2025 01:48:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 31 Oct 2025 15:19:32 +0800, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> This patch series adds support for RT9756 charger.
> 
> V4
> - Fix sparse error that kernel test robot reported
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: power: supply: Add Richtek RT9756 smart cap divider charger
      commit: 6964258c617759fb4d6be97a434f44a853a7be52
[2/3] power: supply: rt9756: Add Richtek RT9756 smart cap divider charger
      commit: b6f0796d4398beba49c548e07a3d13656acb8fb1
[3/3] Documentation: power: rt9756: Document exported sysfs entries
      commit: 1cda37798599692cb553fdb4e93faa294e1a151b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


