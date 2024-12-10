Return-Path: <linux-pm+bounces-18954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6648A9EBBFE
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE34D2830B2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6683023A56C;
	Tue, 10 Dec 2024 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNhcZIPZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C5F23A561;
	Tue, 10 Dec 2024 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866925; cv=none; b=YSe9OD4GreU+A4aZqSPkeBQkMUVcQS0WZ2sUNz7CpJ6CkCYNIupTYq72zJwiJ8Ftjzt/Ol1g5SQcvsc43oq/POvLw8Vqs5jUx69iUjXQ+2UqURj5DO3SNee2UWhel7s8qzgae/RWvnkM0P2G3SuU0mvaoYUyfA3/4TUO3iFZQDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866925; c=relaxed/simple;
	bh=J7RAxM/q6Q/8DwyccS9Kg3PsZEkN8XyD8RVXJt3my1s=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=cS3fPTnvG852yEh91QZBZpFUXG+LzDUKs3UVXcIy54HCGPPS3F0/0EAjSDUZarLUNoPt2jYf2ZwlU3+iNX6rF1AEcOiMyriE66czo9mhwxNz6ePKx5/DqW45xBfwzUVUz5qxZb9pby8edvAT11sVnakrWzSt1ittgx+r4ATCh7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNhcZIPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCFBC4CED6;
	Tue, 10 Dec 2024 21:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733866925;
	bh=J7RAxM/q6Q/8DwyccS9Kg3PsZEkN8XyD8RVXJt3my1s=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=HNhcZIPZ3f9Tae9yxevgtUmOhA9UE6hjFegL/J7gs1+9JKN9iCVqgVnYqvPMVjYke
	 +wZssjSG5CvWjvFFoNrtPCIlSZVIxUa42MvJ2vHUgU5uNEdIa5OzxEceQy8PTpDzQf
	 8XDQK2FbCnNmYq+gzrn9Dj2hCGr4+VWoEFc1SmzjVBkpuk1MJrnMqb07vGTS9RAIuG
	 qOcqwbnxIVkeE/6/ytrxU9yDQ0Ked2fHToHHN8cAiuI9XyVoGzXjdmAGVtbMCotvxX
	 5yD5fSjFPWaCwXAzi0jguMkvOiQFoPY4jRcLTHztkH/2j7mLyb27pVkS0olnYKC7Ez
	 QrdWXY14WSmkA==
Date: Tue, 10 Dec 2024 15:42:03 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, quic_anubhavg@quicinc.com, 
 Mark Brown <broonie@kernel.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 linux-pm@vger.kernel.org, quic_mohamull@quicinc.com, 
 quic_hbandi@quicinc.com, devicetree@vger.kernel.org, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <20241209103455.9675-1-quic_janathot@quicinc.com>
References: <20241209103455.9675-1-quic_janathot@quicinc.com>
Message-Id: <173386568587.497565.1413799827375300987.robh@kernel.org>
Subject: Re: [PATCH v5 0/4] Enable Bluetooth on qcs6490-rb3gen2 board


On Mon, 09 Dec 2024 16:04:51 +0530, Janaki Ramaiah Thota wrote:
> - Patch 1/4 Add description of the PMU of the WCN6750 module.
> - Patch 2/4 add and enable BT node for qcs6490-rb3gen board.
> - Patch 3/4 use the power sequencer for wcn6750.
> - Patch 4/4 add support for the WCN6750 PMU.
> 
> ----
> Changes from v4:
> * Added reviewed tag by Krzysztof in p1
> * Updated the p2 commit message with sw_ctrl and wifi-enable are
>   handled in wifi FW.
> * Added blank line between the nodes in p2
> * Placed the structures in proper order in p4
> * Link to v4: https://lore.kernel.org/all/20241204131706.20791-1-quic_janathot@quicinc.com/
> 
> Changes from v3:
> * Defined the PMU node and used the its output to power up BT
> * Used power sequencer for wcn wcn6750 module
> * Split the patch to multiple as per subtree
> * Add description of the PMU of the WCN6750 module
> * Include separate UART state node for sleep pin configuarion
> * Link to v3: https://lore.kernel.org/linux-arm-msm/20241022104600.3228-1-quic_janathot@quicinc.com/
> 
> Changes from v2:
> * Sorted nodes alphabetically
> * Link to v2: https://lore.kernel.org/linux-arm-msm/20241010105107.30118-1-quic_janathot@quicinc.com/
> 
> Changes from v1:
> * Corrected the board name in subject
> * Link to v1: https://lore.kernel.org/linux-arm-msm/20241009111436.23473-1-quic_janathot@quicinc.com/
> 
> Janaki Ramaiah Thota (4):
>   regulator:·dt-bindings:·qcom,qca6390-pmu:·document wcn6750-pmu
>   arm64: dts: qcom: qcs6490-rb3gen: add and enable BT node
>   Bluetooth: hci_qca: use the power sequencer for wcn6750
>   power: sequencing: qcom-wcn: add support for the WCN6750 PMU
> 
>  .../bindings/regulator/qcom,qca6390-pmu.yaml  |  27 +++
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  | 168 +++++++++++++++++-
>  drivers/bluetooth/hci_qca.c                   |   2 +-
>  drivers/power/sequencing/pwrseq-qcom-wcn.c    |  22 +++
>  4 files changed, 217 insertions(+), 2 deletions(-)
> 
> --
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y qcom/qcs6490-rb3gen2.dtb' for 20241209103455.9675-1-quic_janathot@quicinc.com:

arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'enable-gpios' is a required property
	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'swctrl-gpios' is a required property
	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'vddio-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'vddbtcxmx-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'vddasd-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: pinctrl@f100000: Unevaluated properties are not allowed ('qup_uart7_sleep' was unexpected)
	from schema $id: http://devicetree.org/schemas/pinctrl/qcom,sc7280-pinctrl.yaml#






