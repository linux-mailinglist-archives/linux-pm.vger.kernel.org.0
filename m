Return-Path: <linux-pm+bounces-9731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A871C911B04
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 08:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29534B23934
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 06:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4393A16727F;
	Fri, 21 Jun 2024 06:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGDULRak"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C44C1649A8;
	Fri, 21 Jun 2024 06:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950297; cv=none; b=rFaBth7bwJ2c+1Yb01eBLIYyLA0hcMYcaNW94N2EdCRMD+1galiMWel3Ntgoi6FQuAx4/tuOYCTriEi4RaZC9hE9y4I3YzU1EJMFPMtY2wuDLZJy5DtUlZDV7l/rlU8b/rAkvwvqhqTANPKvC9AFfB3UlyISCGOogQFQrMrWXH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950297; c=relaxed/simple;
	bh=qfGcRqMiu9FQBxvn+pv49tvvllvHEGuZK1OY/bR0D4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GT+/uu8yo09sO8lsFJ0KZrJjXlsVa1CKfMGt95eN+yLKHNrlu1fSCVkM/2QQgT0YhjkdiEJq4oenPN76aRJ0HN8WcxctnwVSbnfZqEINy4VHts3/FO0UWilABI/mN8kN0uEliDCda+gVKa0QvhcxKoieKOtN0BrawsKK4NzLZgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGDULRak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77582C4AF08;
	Fri, 21 Jun 2024 06:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718950296;
	bh=qfGcRqMiu9FQBxvn+pv49tvvllvHEGuZK1OY/bR0D4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XGDULRakYf5AfYBT6ercKX47nyi1BiSYUHa8r6m0zZZ2xwKARmDUYXA7zuNjxi7bn
	 unZVKSyNxKhvVq4f4Exo8FrYwk/hSd0pKQDz8OdvSLPevkd38fXWQ8Mpyu4yLqNytn
	 811voikjZFsMZIPByOitlJZQ610UCWk++q7OFR35adGzQYT70wghd7ZW1HYZje8s7s
	 Gx4vmZpXiU/rqjho8Tvjs/MCd+3AbB/sPJHKUV9HW9cQmcM11hw/el0kvU17y0FiWV
	 mlSvKJcySZ+b/7ozSVCQrCrJ7cGpw1yeulvqwScrpIHZs4biggD+UQo8ivNYG2YB+7
	 Zo9h4On62kNEw==
From: Bjorn Andersson <andersson@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Nikita Travkin <nikita@trvn.ru>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v7 0/6] power: supply: Lenovo Yoga C630 EC
Date: Fri, 21 Jun 2024 01:11:18 -0500
Message-ID: <171895028796.12506.1483771807923414434.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614-yoga-ec-driver-v7-0-9f0b9b40ae76@linaro.org>
References: <20240614-yoga-ec-driver-v7-0-9f0b9b40ae76@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 14 Jun 2024 02:43:37 +0300, Dmitry Baryshkov wrote:
> This adds binding, driver and the DT support for the Lenovo Yoga C630
> Embedded Controller, to provide battery information.
> 
> Support for this EC was implemented by Bjorn, who later could not work
> on this driver. I've picked this patchset up and updated it following
> the pending review comments.
> 
> [...]

Applied, thanks!

[5/6] arm64: dts: qcom: sdm845: describe connections of USB/DP port
      commit: 1ef3a30f4dc953a8da7aa68ee4658dc7c3710aac
[6/6] arm64: dts: qcom: c630: Add Embedded Controller node
      commit: 060a1ebd91c1f1bdce8433d559f214204b835add

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

