Return-Path: <linux-pm+bounces-34092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D28DB477B9
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 23:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BFC87AE37F
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 21:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EEC29C326;
	Sat,  6 Sep 2025 21:45:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E033629BD90;
	Sat,  6 Sep 2025 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757195110; cv=none; b=IahxIYCZ9jutp9t6DeLO2fFyXtgoJj84BmCRnfZq+LE2P9OSYs7OsusCw3i51UN0Vz4oM5GL84K6oIYenxG/UOKon58QyrPQGpPCKJ/6iKMk6CXevyPQKdQfnjOuFtAhqnpzvxNXb038DxClY0y5UotNdtZt8ZAZm9lVWkW7XKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757195110; c=relaxed/simple;
	bh=uKo9S0PrCoLXQA4Jz0lY37nGz4Ly4DOwn763W+m0SxE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RrnPVMvj39zqR7EziRTCpuJemRJ7ktPb/7xshtZIj/xK38zFryS7wy96aQ0K6nNamETFnmAbTfL2dJC9d3jIWgXceYlkapbJw9xE1H5kjr02KklSTfb7dGDFr14mjkZo9EEm3WowZN+l1hlxoMN4ZwgQGTJEsh4prWgLTFsDTPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79048C4CEFA;
	Sat,  6 Sep 2025 21:45:10 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id D1808180B43; Sat, 06 Sep 2025 23:45:07 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, cy_huang@richtek.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <54fd32fc23fd959da8aa6508d572ee96de5f6eec.1755156213.git.cy_huang@richtek.com>
References: <54fd32fc23fd959da8aa6508d572ee96de5f6eec.1755156213.git.cy_huang@richtek.com>
Subject: Re: [PATCH RESEND^2] power: supply: rt9467: Add properties for
 VBUS and IBUS reading
Message-Id: <175719510785.45380.12579167558244596422.b4-ty@collabora.com>
Date: Sat, 06 Sep 2025 23:45:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 14 Aug 2025 15:27:41 +0800, cy_huang@richtek.com wrote:
> Since there's the existing ADC function, add properties 'VOLTAGE_NOW'
> and 'CURRENT_NOW' to report the current VBUS and IBUS value, respectively.
> 
> 

Applied, thanks!

[1/1] power: supply: rt9467: Add properties for VBUS and IBUS reading
      commit: 15a84d15a677533afa55010f1e2052a27fcd854d

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


