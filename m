Return-Path: <linux-pm+bounces-10427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8561924F6F
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 05:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567CE285AE5
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 03:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4727E1B95B;
	Wed,  3 Jul 2024 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hsp43S4V"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130BA10940;
	Wed,  3 Jul 2024 03:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719976316; cv=none; b=huc2AkkkPqoPe3ZXKUn9181OlYuG9+pb0G2zlsReez+GoNtbD5KEn5MczOKNccbp9OHlsnhSM7Gq6eWHhoxP/TC0L2S3LQCf0/pWs0UE4RCTUvCFlLGbmMQLHy9o8TAP+j0nOX/+PUVEU2vxbxDdMHQ2UgdE04dyPycYQZ/mSw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719976316; c=relaxed/simple;
	bh=EckFuc2G6e24gbSCtrnuGLAJ+uBH7jfedn62oxAzDIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSQLIdXVn5CJkOM+KGklNCHom/+oV98u9cvln3yiBK0EZVyHIEvg0Tz1CdhoLJjagnaBvEu4VciSpwChyXmyRWhHzpMvsIlePY2f9I4DAVU7WnUdCVuDZFDILBSDS/gqdahk5VYC/jyl2cw7jPkEC/v3nNiOiHGYCH9qY71fsT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hsp43S4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A749BC116B1;
	Wed,  3 Jul 2024 03:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719976315;
	bh=EckFuc2G6e24gbSCtrnuGLAJ+uBH7jfedn62oxAzDIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hsp43S4Vcowelqk5wUiF/D7tcn3wc2undHn5kJ1W1+0AHQbJLvUsrZ3+kfksrSBV1
	 9HnO8wf8N0hOor1o2itJKZX33KLfi4F1Llhafv4NBU6xIoyxmsFSIE5uBiDFeTOKJw
	 WgINyGFIw/bVcvVy6PpeUxbC8Lx3jhxZnYbTdpk4EjAo+SOZ03sgoGG97oT/GQ8pWl
	 hqbspz3J3U/lx8EsfU2MUteo/QMWqjslkbbInf+T1Atch6kId2uOS0lehwGvi+dE7R
	 fKbY+0/Lyu5fwOFXXO9tuEKHYZKJz0S7rbGaMzxSclAWUUq8wxRIQYKpWhL72KRgeD
	 82t+tj5t1u47g==
Date: Tue, 2 Jul 2024 22:11:51 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Andy Gross <agross@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Abel Vesa <abel.vesa@linaro.org>, linux-pm@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Taniya Das <quic_tdas@quicinc.com>, Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Ajit Pandey <quic_ajipan@quicinc.com>
Subject: Re: [PATCH V7 0/5] Add control for switching back and forth to HW
 control
Message-ID: <jgokew5qc5oxjlxvmawgkzfve4eov2shfz2ke5l4nisnidetko@ylcp4iesj3mg>
References: <20240624044809.17751-1-quic_jkona@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624044809.17751-1-quic_jkona@quicinc.com>

On Mon, Jun 24, 2024 at 10:18:04AM GMT, Jagadeesh Kona wrote:
> This series adds support for dev_pm_genpd_set_hwmode() and dev_pm_genpd_get_hwmode() APIs
> and support in gdsc genpd provider drivers to register respective callbacks and a venus
> consumer driver example using above API to switch the power domain(GDSC) to HW/SW modes
> dynamically at runtime.
> 

Ulf, I discussed the concerns I had with Taniya and I think this looks
good. Please pick the gdsc/clock patches through the pmdomain tree.

Regards,
Bjorn

> Changes in V7:
> - [PATCH 3/5]: Updated the comment description in gdsc_set_hwmode as per V6 review comments
> - Added R-By tags received on V6
> - Link to V6: https://lore.kernel.org/all/20240619141413.7983-1-quic_jkona@quicinc.com/
> 
> Changes in V6:
> - [PATCH 3/5]: Added details for 1usec delay in gdsc_set_hwmode()
> - [PATCH 4/5]: Updated commit text
> - Added R-By and T-By tags received on V5 RESEND
> - Link to V5 RESEND: https://lore.kernel.org/all/20240413152013.22307-1-quic_jkona@quicinc.com/
> - Link to V5: https://lore.kernel.org/all/20240315111046.22136-1-quic_jkona@quicinc.com/
> 
> Changes in V5:
> - Updated 1st patch as per V4 review comments to synchronize the initial HW mode state by
>   invoking ->get_hwmode_dev()callback in genpd_add_device()
> - With above change, SW cached hwmode will contain correct value initially, and it will be
>   updated everytime mode is changed in set_hwmode, hence updated dev_pm_genpd_get_hwmode()
>   to just return SW cached hwmode in 1st patch
> - Updated commit text for 1st, 3rd, 4th and 5th patches
> - Updated 3rd and 5th patches as per review comments received on V4 series
> - Added R-By tags received in older series to 1st and 2nd patches
> - Link to V4: https://lore.kernel.org/all/20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org/
> 
> Changes in V4:
>  - Re-worded 1st patch commit message, as per Bjorn's suggestion, and added
>    Dmitry's R-b tag
>  - Added Bjorn's and Dmitry's R-b tags to the 2nd patch
>  - Re-worded 3rd patch commit message, to better explain the HW_CTRL_TRIGGER flag.
>  - Added mode transition delay when setting mode for GDSC
>  - Added status polling if GDSSC is enabled when transitioning from HW to SW
>  - Re-worded 4th patch commit message to better explain why the
>    HW_CTRL_TRIGGER needs to be used instead
>  - Drop changes to SC7180, SDM845 and SM8550 video CC drivers, as only
>    SC7280 and SM8250 have been tested so far. More platforms (with v6 venus)
>    will be added eventually.
>  - Call genpd set_hwmode API only for v6 and dropped the vcodec_pmdomains_hwctrl.
>  - Re-worded 5th patch commit message accordingly. 
>  - Link to V3: https://lore.kernel.org/lkml/20230823114528.3677667-1-abel.vesa@linaro.org/ 
> 
> Changes in V3:
>  - 5th patch has been squashed in the 4th one
>  - Link to V2: https://lore.kernel.org/lkml/20230816145741.1472721-1-abel.vesa@linaro.org/
> 
> Changes in V2:
>  - patch for printing domain HW-managed mode in the summary
>  - patch that adds one consumer (venus)
>  - patch for gdsc with new (different) flag
>  - patch for videocc GDSC provider to update flags
>  - Link to V1: https://lore.kernel.org/all/20230628105652.1670316-1-abel.vesa@linaro.org/
> 
> Abel Vesa (1):
>   PM: domains: Add the domain HW-managed mode to the summary
> 
> Jagadeesh Kona (3):
>   clk: qcom: gdsc: Add set and get hwmode callbacks to switch GDSC mode
>   clk: qcom: videocc: Use HW_CTRL_TRIGGER for SM8250, SC7280 vcodec
>     GDSC's
>   venus: pm_helpers: Use dev_pm_genpd_set_hwmode to switch GDSC mode on
>     V6
> 
> Ulf Hansson (1):
>   PM: domains: Allow devices attached to genpd to be managed by HW
> 
>  drivers/clk/qcom/gdsc.c                       | 41 ++++++++++
>  drivers/clk/qcom/gdsc.h                       |  1 +
>  drivers/clk/qcom/videocc-sc7280.c             |  2 +-
>  drivers/clk/qcom/videocc-sm8250.c             |  4 +-
>  .../media/platform/qcom/venus/pm_helpers.c    | 39 ++++++----
>  drivers/pmdomain/core.c                       | 78 ++++++++++++++++++-
>  include/linux/pm_domain.h                     | 17 ++++
>  7 files changed, 161 insertions(+), 21 deletions(-)
> 
> -- 
> 2.43.0
> 

