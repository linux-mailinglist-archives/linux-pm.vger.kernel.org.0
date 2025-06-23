Return-Path: <linux-pm+bounces-29404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27389AE4E10
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 22:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C04D3B599D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 20:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1AE2D4B57;
	Mon, 23 Jun 2025 20:20:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A301A1F5617;
	Mon, 23 Jun 2025 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750710042; cv=none; b=KG3qefkrrTAWzSwP0yFBfiURenv9vYyHaox3q16H/PS1dkeJNNH8q36TIpkpLFLpHlXDd1+KIfTQmZCZ1SuSzoa1wYlVVEFWM09V6zqQxeJx7rtnPgl0ib3GTT6Q6xlQKs2EQ3+U3o7g0DK6xESlUGgtNN8yYaT0fD+lPKkIK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750710042; c=relaxed/simple;
	bh=oA0p1uClGqR3l4grX3HCmwZac9lhKQOM+VdvDFnTmjw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Mt3pDXfTwXgmkEBFM/kNG2KZEKCiPYW9Gni2Gt43ChiqvoD3QzMHUMFyjiU9ax2R+KvZRV8l/ZLozv8goGpn4ZGNpm83JqhGot7IELqPDtyq5r7a8lFSc3AXKHMkhrhchWkEbqQ2YlX83HUXM9sZU2e/MKaAnePYbgROSH2uWLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EF0C4CEEA;
	Mon, 23 Jun 2025 20:20:41 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 20D56180AAD; Mon, 23 Jun 2025 22:20:39 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 Lukas Bulwahn <lbulwahn@redhat.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
In-Reply-To: <20250623081240.149446-1-lukas.bulwahn@redhat.com>
References: <20250623081240.149446-1-lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: rectify file entry in QUALCOMM SMB
 CHARGER DRIVER
Message-Id: <175071003911.362465.10205242431395773807.b4-ty@collabora.com>
Date: Mon, 23 Jun 2025 22:20:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 23 Jun 2025 10:12:40 +0200, Lukas Bulwahn wrote:
> Commit 4deeea4b0741  ("MAINTAINERS: add myself as smbx charger driver
> maintainer") adds the section QUALCOMM SMB CHARGER DRIVER in MAINTAINERS,
> including a file entry pointing to qcom_smbx_charger.c. Within the same
> patch series, the commit 5ec53bcc7fce ("power: supply: pmi8998_charger:
> rename to qcom_smbx") renames qcom_pmi8998_charger.c to qcom_smbx.c and not
> to qcom_smbx_charger.c, though. Note that the commit message clearly
> indicates the intentional removal of the "_charger" suffix.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: rectify file entry in QUALCOMM SMB CHARGER DRIVER
      commit: d375b70a0f47a032813be33493c97133cc080f74

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


