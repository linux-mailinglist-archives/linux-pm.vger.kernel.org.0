Return-Path: <linux-pm+bounces-18603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 519CE9E4F41
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 09:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F6B1881E88
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 08:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3033A1CF5DF;
	Thu,  5 Dec 2024 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nobqjFQJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94E51CEEBB;
	Thu,  5 Dec 2024 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385997; cv=none; b=T057xRoLEAaPb+o2AfGeelfEONUB99NhM+K9qEdkqNII4x0YeHZCC+IdX0c08Kx9OkuQc00kk17MX1piwzQyksYK+sJRonTZSbmXawdYSSG1mQyGUq11H5rKTpykDb1NH/8Vdt8xQJFBykf3dsJKA6FmlnI5fQexE7br32qpsKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385997; c=relaxed/simple;
	bh=/2w/IZWodnXLjnDI5CCUh+h5MeVbRFH42s5kb0Gi3Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kik96C8igaYcCvqpaexKPk8FDdBpWAlEtYddFCFQ3OJR1ehIDNS6GH1kBGF6v7LSqFxvoLyUayHNBr+ttjoRMbQMaKyw3SoXiCDwNX2kHD5CXeimJ+z3FZ5doCTEQ4t90YBgojR99bbCOws5VGDVzmPRB3Vysgq0FrILQvynUzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nobqjFQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A550EC4CED6;
	Thu,  5 Dec 2024 08:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733385996;
	bh=/2w/IZWodnXLjnDI5CCUh+h5MeVbRFH42s5kb0Gi3Wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nobqjFQJYr5wFeRYO6AHYCPmdUmHS8hFzW34DmNyRINhH8/vN3S75K6mcrBa0fr4X
	 0OzJd9FlcznalHWTQ03V6vCKiZZa47ac3RrQw7B1U5llZkpYWN9VQ9vF7kOt4JuALw
	 idJTD1wW89MPSWi/2FbRg/ixqLx29E+5kDmSoehrn2LiIpK8S6/O1LYwrArqpO4cL2
	 4utFUOeEmkP9+DerAhSnl6BTOu547om2C4Pa7I2x/fq0N3f7JQTphzWX/nk9tREHow
	 FoY7Oab9l+UNmZYMDtRSEFDR7gCUYZfMoyelVwnB4NKHVLSR+rf/u1myUe94ii93su
	 MJlk4DMA6jG/A==
Date: Thu, 5 Dec 2024 09:06:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/4] =?utf-8?B?cmVndWxhdG9yOsK3ZHQtYmluZGluZ3M6wrdx?=
 =?utf-8?Q?com=2Cqca6390-pmu=3A=C2=B7document?= wcn6750-pmu
Message-ID: <hisevtvvebbypne4q7w6zq36jfrgu2ni7mfvdls5bukuivrn5n@rwxutcjd25en>
References: <20241204131706.20791-1-quic_janathot@quicinc.com>
 <20241204131706.20791-2-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204131706.20791-2-quic_janathot@quicinc.com>

On Wed, Dec 04, 2024 at 06:47:03PM +0530, Janaki Ramaiah Thota wrote:
> Add description of the PMU of the WCN6750 module.
> 
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>

Subject is mangled.

What's more, you received a *very clear* instruction what to do on your
previous v4. This is also v4, but that's not the point. Why you ignored
the instruction?

Instruction is there because "many review tags are being ignored" and,
well, did not help! I don't know how to write it clearer.

Best regards,
Krzysztof


