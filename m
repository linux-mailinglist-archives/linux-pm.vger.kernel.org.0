Return-Path: <linux-pm+bounces-8667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2D98FD931
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 23:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17C41C21F41
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 21:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B58F15E5D5;
	Wed,  5 Jun 2024 21:38:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51480944D;
	Wed,  5 Jun 2024 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623491; cv=none; b=n4TH3vVD46jTuWbrXYJ5rkhtb6ViYKY4/C9MBB6VdbCmAEHOkK2aX+xCPRFf+nM3sZCmLBD4nZHHIdieBx9jIZWYyI4vZTdzlODuZBULjtRqLavvxNzAnKUzzNo+DJXbWah3QmOsSmaehyQaLI8ZhNpKaFVt2H6TStfUJUOZpO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623491; c=relaxed/simple;
	bh=f2DG9QdFofJhj1dXNMPCljWpJHmHcwO6RpXhGmD+fE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Iq/dGSrpKjdfAnZSRuugxTmN3xWb4qdbCSAVG5snb0bwENnof8QVYmePj9DtGWvxpC4DrzQDnkta/UFrarBs3NZfpNFydqJ7Xl6NFseBQ7N629BC6mSeks6qAkwt4k9WsiUhVVlY0a0ei7ou0uLn88o/X5SD9hjodRog9NZHEec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8F4C2BD11;
	Wed,  5 Jun 2024 21:38:10 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id F2860106066C; Wed, 05 Jun 2024 23:38:07 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linus.walleij@linaro.org, mazziesaccount@gmail.com, sre@kernel.org, 
 linux@treblig.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240528000634.196707-1-linux@treblig.org>
References: <20240528000634.196707-1-linux@treblig.org>
Subject: Re: [PATCH 0/2] power: dead struct removal
Message-Id: <171762348797.363491.16712112134214134918.b4-ty@collabora.com>
Date: Wed, 05 Jun 2024 23:38:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 28 May 2024 01:06:32 +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> A couple of dead struct removals in drivers/power
> 
> Build tested.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> [...]

Applied, thanks!

[1/2] power: supply: bd99954: remove unused struct 'battery_data'
      commit: ef1f6783fe03bee6acc15ef7084ab8b64c38d769
[2/2] power: supply: ab8500: remove unused struct 'inst_curr_result_list'
      commit: a5dd84f3bde0252cb39a3ecebbe71d7c2b405194

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


