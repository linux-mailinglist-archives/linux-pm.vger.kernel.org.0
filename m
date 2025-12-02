Return-Path: <linux-pm+bounces-39089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 940F8C9C601
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 18:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3DE81346863
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 17:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AD32C0261;
	Tue,  2 Dec 2025 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqnqqqjo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8592BE629;
	Tue,  2 Dec 2025 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696114; cv=none; b=dSplVS9AQ5E31lYC3JKQIW3vHo9pLbv/rRys3wYjsBHrXv7BIs4awqT6XgsX7kqhUNkTVFF82gf2nRM3WfHUmckSpGpL5aOHCSHrYQY9miX/XuDpn67KtNxn+JVyok9PrmsiA8GwDrROFYrM9aUlnbp6u0ZqxII6h0AeN8MjBTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696114; c=relaxed/simple;
	bh=kX8K5t17HV0DWjX3NltWvhbVwDGEkQRSKNr7trTJUJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DE3xxtdnCrKLdSpNUhwy/Lfy4Bmu8rT0jP6iM7pEROTc/vbjOoDef6wnMMWfv0ugvd1Y8veLh/WB5ApA3KgXh7/7vqHeqZjC7m9DlJtp+MVw1NJ64KyiTDx/7l7mC5Swhi/TXme/hm++pXuBdDkKjs+dcemcFk+M3llvDl+0mLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqnqqqjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EE5C4CEF1;
	Tue,  2 Dec 2025 17:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764696113;
	bh=kX8K5t17HV0DWjX3NltWvhbVwDGEkQRSKNr7trTJUJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqnqqqjokjYyxU9R1l3VM1F3qt721FcblTx3E12wSHlUyfOJlsqw4sccvT/wYYB+6
	 18pyEsVSKxqZXiESPBb7+1XX7mZ9WE91/nKr8jWNPnFRDlzYYMdQkLCztSi4hADKGL
	 83dIdnY6m0fuIwTRb8Eb+BaZ2JkK6vFFmIhdMQaX5sOEK0hfs7jqJFmdXGnFWLyjnr
	 3ZCPCYQKo35TxodoER/4EZuvZb5rOB02sG5w2O9cEGsZb3gtVCUdEa1/rT0QhWMOQq
	 iEBf+PerqQUUG6fZ6FA/j/T+/vda7oulSznSDJm3GLV2FeeDZEoBFYl8bp3OCRbcau
	 5Ly+aWg4gGNCQ==
Date: Tue, 2 Dec 2025 11:27:54 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH 0/5] Define VDD_MXC for SC8280XP
Message-ID: <fcwblitx5v2brfl67ckv7vy4ljwqgq26p33brbjubywjvweurx@74hprmodblf3>
References: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
 <176418784438.1591314.8587929353938909456.b4-ty@kernel.org>
 <20251201201440.GA4041208-robh@kernel.org>
 <CAPDyKFoGQJA5UY-96HvfoA7WMb5wYFXFFfFREpMmK29GE7-Nag@mail.gmail.com>
 <bb6f83cc-4f6a-44f8-9997-fb91e7c2b4cb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb6f83cc-4f6a-44f8-9997-fb91e7c2b4cb@oss.qualcomm.com>

On Tue, Dec 02, 2025 at 02:27:59PM +0100, Konrad Dybcio wrote:
> On 12/2/25 10:19 AM, Ulf Hansson wrote:
> > On Mon, 1 Dec 2025 at 21:14, Rob Herring <robh@kernel.org> wrote:
> >>
> >> On Wed, Nov 26, 2025 at 02:10:41PM -0600, Bjorn Andersson wrote:
> >>>
> >>> On Tue, 04 Nov 2025 20:31:05 +0100, Konrad Dybcio wrote:
> >>>> This has somehow been omitted, leading to potentially stale votes.
> >>>> On the flip side, the domain will now be powered off, which will
> >>>> uncover any omissions we've made in the DTs so far.
> >>>>
> >>>> Reasonably tested on an x13s without pd_ignore_unused (camera still
> >>>> works).
> >>>>
> >>>> [...]
> >>>
> >>> Applied, thanks!
> >>>
> >>> [2/5] dt-bindings: remoteproc: qcom,sc8280xp-pas: Fix CDSP power desc
> >>>       commit: ca079ec3ebed19a12c1bf080496dacbc6fdfbb39
> >>
> >> This has was picked up, but the .dts change was not, so there's a bunch
> >> of new warnings. What's the plan? I know it's separate trees. Can you
> >> please take binding and .dts changes like these together if there aren't
> >> driver changes?
> > 
> > I was planning to pick up the driver (pmdomain) and dt doc changes, as
> > usual. Although, I was waiting for the discussion to reach consensus
> > around dts patch (patch5), maybe it did?
> > 
> > Björn, perhaps easier if you pick the series via your qc-soc tree and
> > send them as fixes? If so, feel free to add my ack on patch4 (the
> > pmdomain patch).
> 
> FWIW the part where the CDSP power-domain list changes still applies,
> even though I was wrong about the CAMCC requiring that too..
> 
> I can resend if needed
> 

Yes, please respin a version without the camera change, I can pick up
the remaining patches as -fixes.

Regards,
Bjorn

