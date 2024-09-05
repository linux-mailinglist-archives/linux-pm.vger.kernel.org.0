Return-Path: <linux-pm+bounces-13698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A351C96DBDB
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 16:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5B81F26147
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 14:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9C8182A0;
	Thu,  5 Sep 2024 14:32:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D45617C9B;
	Thu,  5 Sep 2024 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546730; cv=none; b=bE4rfM/EmFR+HQNkLdxmxGot95RSrvASJ16NpPGaFlewb5/vACR+pvCJuU2rtivSAJg7kQGgRGissHXBhMP9jtfTxu6PCdVQpmS0nYxEwVYqWJYApHsF0C4uuE1zVMgUxfiwjhxMI97K9TLV5gj6B8/pP+4945E3/bjks5ZiV0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546730; c=relaxed/simple;
	bh=55OjlP3iUWYoGk6en4lD65WOZ0/EzVYL/xp/dr2dwxk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rauG/roE2beEcM5vY4iYbKRL6MVWHeda3Mx3CiUt7L9q2iFGSyvo18YcdQNtCM+gHBmXR0Os8YFuuesrNeMQy/36OOU4YUqiIdHEWeBY2FDodEBvB17BLsAarLQbdFlJOfnPBS8fwIgQEZmLAbjfxRVsewHD3hStWD9PxmBVRXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A028C4CEC5;
	Thu,  5 Sep 2024 14:32:09 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 2436510604BA; Thu, 05 Sep 2024 16:32:07 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <9c2f76e7-5679-473b-9b9c-e11b492b96ac@stanley.mountain>
References: <9c2f76e7-5679-473b-9b9c-e11b492b96ac@stanley.mountain>
Subject: Re: [PATCH next] power: supply: fix a double free on error in
 probe()
Message-Id: <172554672712.1074347.2449586209838548923.b4-ty@collabora.com>
Date: Thu, 05 Sep 2024 16:32:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Thu, 05 Sep 2024 16:28:59 +0300, Dan Carpenter wrote:
> In this code, if devm_add_action_or_reset() fails, it will call
> max1720x_unregister_ancillary() which in turn calls
> i2c_unregister_device().  Thus the call to i2c_unregister_device() on the
> following line is not required and is a double unregister.  Delete it.
> 
> 

Applied, thanks!

[1/1] power: supply: fix a double free on error in probe()
      commit: 48f703d6a3d7cf345fe9c6209ea3703fe9024628

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


