Return-Path: <linux-pm+bounces-19471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDAB9F7142
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 01:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF0218907B9
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 00:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57EC2111;
	Thu, 19 Dec 2024 00:11:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B642B1853;
	Thu, 19 Dec 2024 00:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734567066; cv=none; b=oaes99DRgga9D4Xguuazi6iRyYmcipll6qtyG6xlbuiejeOxsvLos508i5lz6ziDFJ/F6BnfD72Onr25tU/auvVONCH6qNcaDH+ePdOFTFLxzC/QXSuUECOfdSpfMlmuRyt3/wHf8dQJY9Dl6hgEGwFfviYoeRyakji0giIo4QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734567066; c=relaxed/simple;
	bh=H8uVu5PkJDGZ4XihBgIR+9LaH3ukoYvjV78WN3iDA10=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BG0cr3BE0X36tbh8Pml+fuyoMwabAXjqjGnx9zc26r72lyyCMiWbcFYOPtzQ3E1E4XQOiIQQy9rn1w1aOH3nDhjsRwC+iYN534tCHuZ/K1VALGIXiVMvNp+R04ak86RXMiSE2IlmnswLN9v6vYsT/qAxYTZEef6iCmGaqOuN6Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1558CC4CECD;
	Thu, 19 Dec 2024 00:11:06 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 4F14B1060345; Thu, 19 Dec 2024 01:11:03 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc: pali@kernel.org, sre@kernel.org, linux-kernel@vger.kernel.org, 
 maemo-leste@lists.dyne.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20241128085759.11840-1-absicsz@gmail.com>
References: <20241128085759.11840-1-absicsz@gmail.com>
Subject: Re: (subset) [PATCH 1/2] power: supply: bq2415x_charger:
 Immediately queue delayed work on supply change events
Message-Id: <173456706329.3128930.15313950900801031968.b4-ty@collabora.com>
Date: Thu, 19 Dec 2024 01:11:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 28 Nov 2024 10:57:27 +0200, Sicelo A. Mhlongo wrote:
> bq2415x_notifier_call is called asynchronously, when a change is notified
> from the external notify device. Therefore, reschedule the work item to
> run as soon as possible thereafter.
> 
> 

Applied, thanks!

[2/2] power: supply: bq2415x_charger: report charging state changes to userspace
      commit: 5972da73f75af6002b72e5cd61002855b6b4eda3

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


