Return-Path: <linux-pm+bounces-17352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C9F9C48E0
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 23:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51B9284E5E
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 22:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66131BFDEC;
	Mon, 11 Nov 2024 22:13:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4101BCA1C
	for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363216; cv=none; b=bStiV1wXJXqSaSgvs25zESyM6EiyKu+i3F49Lc6ZEhVxaqovwhJM1Ss5dZ4dH1Y70xq92ozU/5KALrlEsSlggQ6VS3Zuxd6JsHFt3yxj8eq60RX+mILN/wiOapgtOBPYNhMIVQG+qCbitApbqBr3abTDh3h+9pf6MZTJ9jyw+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363216; c=relaxed/simple;
	bh=Eo/cQQe68FccgQImMskizb5nVyG4dXJqkudmaGxi4A4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q0QGxjs+p5JjbDYlsOAKTBroy2+pljOc+0B5NVA+C87nWd2WUm9Uiq5F6nrJxv7IttD5Q0AUR2nVfZk85/lrUHEa+AFV420Ns1Vy6Hpu6GsiOwpNFWe2X4YD2wVm8Vi9wnQzWcsVmOfslOfIU18wqvpG/yUKmdUCmipDpnxe07Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A268C4CED5;
	Mon, 11 Nov 2024 22:13:36 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 41B9D1060457; Mon, 11 Nov 2024 23:13:34 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, Ed Robbins <edd.robbins@googlemail.com>
Cc: sre@kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <IOFJLS.120OJ5KJG9R72@googlemail.com>
References: <IOFJLS.120OJ5KJG9R72@googlemail.com>
Subject: Re: [PATCH] pmu_battery: Set power supply type to BATTERY
Message-Id: <173136321424.772650.12097145596022478925.b4-ty@collabora.com>
Date: Mon, 11 Nov 2024 23:13:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 18 Oct 2024 07:07:30 +0100, Ed Robbins wrote:
> If the power supply type is not set it defaults to "Unknown" and upower
> does not recognise it. In turn battery monitor applications do not see a
> battery. Setting to POWER_SUPPLY_TYPE_BATTERY fixes this.
> 
> 

Applied, thanks!

[1/1] pmu_battery: Set power supply type to BATTERY
      commit: 3287673c1d26f94845ef958090c583c46054b70d

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


