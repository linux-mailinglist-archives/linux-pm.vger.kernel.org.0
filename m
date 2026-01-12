Return-Path: <linux-pm+bounces-40627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DDED104D6
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 02:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 364DF3049FE7
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 01:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F30C24EA90;
	Mon, 12 Jan 2026 01:56:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F8A23C51D;
	Mon, 12 Jan 2026 01:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768182971; cv=none; b=tOixoAUXijyQQlhXAgLWeV8/ByjhwGaqZ3qKnLebIZRtRJuDy5yhSlmfcRpWNPyO9qVg+zhg+g4iYucLDtclMCKjxlxX17MrJdvvkUv/4NLZL/jJc0oWoHKp6++XOwskjWe0r7q06QW0lCKOWONbcCJZoT8AwWgmXC+ajBSK9pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768182971; c=relaxed/simple;
	bh=gtvXV583ORaLOmJUqMEMXsmJmix52zhIUzK+zquHawY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KO4ryXNOyyxKsHnmIbUP8hrNL+uYkDIhSDBDJQCnTh/+sCrof1GGfADYq8UUj9WnchLxKIij5G2cOU1MxYB9zvbFmU7jJ7zqeUIHXzAABHGTbCcaM7ONKThj+aTwp0JgZxbebQPHZmwrpltb95N35TIQUogZTlDdTgtkkdXGr+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3EBC4CEF7;
	Mon, 12 Jan 2026 01:56:08 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 363C518088B; Mon, 12 Jan 2026 02:56:04 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, jonghwa3.lee@samsung.com, 
 Julia Lawall <Julia.Lawall@inria.fr>
Cc: yunbolyu@smu.edu.sg, kexinsun@smail.nju.edu.cn, ratnadiraw@smu.edu.sg, 
 xutong.ma@inria.fr, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260104171644.292437-1-Julia.Lawall@inria.fr>
References: <20260104171644.292437-1-Julia.Lawall@inria.fr>
Subject: Re: [PATCH] docs: power: update documentation about removed
 function
Message-Id: <176818296420.643060.10897565020550859485.b4-ty@collabora.com>
Date: Mon, 12 Jan 2026 02:56:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 04 Jan 2026 18:16:44 +0100, Julia Lawall wrote:
> The function cm_notify_event() was removed in commit 9584051f3cf3
> ("power: supply: charger-manager: Remove cm_notify_event function").
> Remove the documentation that suggests how it can be used.
> 
> 

Applied, thanks!

[1/1] docs: power: update documentation about removed function
      commit: 432b119ab8d8bf1f550c247f7fbe960e87ba6c92

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


