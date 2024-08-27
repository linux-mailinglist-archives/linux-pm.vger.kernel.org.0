Return-Path: <linux-pm+bounces-12981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3459613F0
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 18:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6181C23440
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6791CCB28;
	Tue, 27 Aug 2024 16:25:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D259D1C4EE3;
	Tue, 27 Aug 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775933; cv=none; b=SHsn6FnoryFGdA2vNi8QVT0vkDLx6UxWj9i74QljweuVXg0Sm623P/tLh2PHx5S3ZKx40vKQzFR5jBlModxf9b6NaSrkCXvhieazWiZsDXxzKKIeoOD7Qgtfvph5sd/g+/gwd9pvRt4BreZRUdCFoPFnrlJW98OvBDRFwh6pWZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775933; c=relaxed/simple;
	bh=henAKoUNAaByuZc9acrEy1/IV4+TOUcMIWvjZUSrQEA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BhJvfK01TwtXanNbGYeI3TuINneWRgv9FOVcW3TE3sEali0eVLNQ8it36KztZ2FHl/ozGZnNSFxKjfJF8VximD/w9HVW8sXjB1Kd7a/kcwSnhae9IBA0Sdz/Cq167cOsQHJ6f56yzcsgK98VLqhcjVeDCVDeAbaOpmEmCW+OzUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55906C8B7B7;
	Tue, 27 Aug 2024 16:25:33 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 3BD591060534; Tue, 27 Aug 2024 18:25:31 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <Zr3SAHlq5A78QvrW@standask-GA-A55M-S2HP>
References: <Zr3SAHlq5A78QvrW@standask-GA-A55M-S2HP>
Subject: Re: [PATCH] dt-bindings: power: supply: sc27xx-fg: add low voltage
 alarm IRQ
Message-Id: <172477593123.353499.162167504738447806.b4-ty@collabora.com>
Date: Tue, 27 Aug 2024 18:25:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Thu, 15 Aug 2024 12:01:36 +0200, Stanislav Jakubek wrote:
> The SC27XX fuel gauge supports a low voltage alarm IRQ, which is used
> for more accurate battery capacity measurements with lower voltages.
> 
> This was unfortunately never documented in bindings, do so now.
> 
> 

Applied, thanks!

[1/1] dt-bindings: power: supply: sc27xx-fg: add low voltage alarm IRQ
      commit: 17656d2215c3978bbe2811a5e249cd07fe3de77f

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


