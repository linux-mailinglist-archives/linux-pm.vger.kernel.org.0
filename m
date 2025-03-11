Return-Path: <linux-pm+bounces-23891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE430A5CEF5
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 20:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D7B47AB327
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 19:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD74264A65;
	Tue, 11 Mar 2025 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBnUNgfm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDDE2641C2;
	Tue, 11 Mar 2025 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741720090; cv=none; b=Komp9NGweSD/BjbhgTVhDJkvZZDAjVCl5peCP/4vkbTD1McAu48K/Jl7dxT9F9emn3us4sL7IMIcgWu/8qPGXE2H/yrlMv6UCCOwMpaDboZqfZ3bm5igDOBXBjtALg46x5qBHLUzAK5wALTe1+HywmtxBPX4ekn1NbD6X+hy5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741720090; c=relaxed/simple;
	bh=xeRfUAD1jft9a1eCHnyKsJSSNEwpqQuywYP7E6aXL8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlh0YelimhWKhcXN5R+f7bK0CEPeG7jAqs/UhJjKX8AH1EINu+ydPwkfHcMYQaWVs+e5wbGXAW60P1S/b1By6u8hgoYbbO3yNhjEzv0TFNULCTSqIlHXRwo0HjMW9cBRoPUsTHJk0ImbhWtUdWHPQdddAL4U6cPUb/FNTbDtljE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBnUNgfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DB3C4CEE9;
	Tue, 11 Mar 2025 19:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741720090;
	bh=xeRfUAD1jft9a1eCHnyKsJSSNEwpqQuywYP7E6aXL8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBnUNgfmOjojfJTGUs1AUZ73VM/aPmDrhcsqHEU4HxcC4t1WOioQye7pi+Mu+G93l
	 TmMoUl06bBaFGVE3TGxluVpDlzHF3885P1AjRuTyrid3sZ2pAAIgBT+0Kf9ndxs4lf
	 GTPkVDFlHFXUh6hSRGKjWtoLWfur7+SAxvvSoDEUL77sLCZki20Faf53G4t58P/JgT
	 /eU5qTBa1A94P2yA6y+1SsmQLygkdmy6RN9qkSZBSQgZJGlRRkahPNxkFQxH1hQWto
	 A4wD56WDxvfHvE47nxeVIH4jPVdZ1gKhDKc8j6fb1ki9/4wg2phTsA3QeOw0cRxzPY
	 UrPfKyf8R7WzQ==
Date: Tue, 11 Mar 2025 21:08:04 +0200
From: Dmitry Baryshkov <lumag@kernel.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Odelu Kukatla <quic_okukatla@quicinc.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Mike Tipton <mdtipton@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 4/7] interconnect: qcom: icc-rpmh: Add dynamic icc
 node id support
Message-ID: <pumodlsgqa43tq6c7hmk4eimf5u26dm3wvra2y27lmu3l6rhks@pjpnhp72pggo>
References: <20250227155213.404-1-quic_rlaggysh@quicinc.com>
 <20250227155213.404-5-quic_rlaggysh@quicinc.com>
 <gxqjfabcqafqjzzwc3seadfuldqfxlfappsotjbhkbirvorcyd@mahdpv6klwn5>
 <5278cb2e-6111-4e57-86b3-987f6f9eabf6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5278cb2e-6111-4e57-86b3-987f6f9eabf6@quicinc.com>

On Mon, Mar 10, 2025 at 07:54:15AM +0530, Raviteja Laggyshetty wrote:
> 
> 
> On 2/27/2025 9:46 PM, Dmitry Baryshkov wrote:
> > On Thu, Feb 27, 2025 at 03:52:10PM +0000, Raviteja Laggyshetty wrote:
> >> To facilitate dynamic node ID support, the driver now uses
> >> node pointers for links instead of static node IDs.
> >> Additionally, the default node ID is set to -1 to prompt
> >> the ICC framework for dynamic node ID allocation.
> >>
> >> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> >> ---
> >>  drivers/interconnect/qcom/icc-rpmh.c | 16 ++++++++++++++--
> >>  drivers/interconnect/qcom/icc-rpmh.h |  3 ++-
> >>  2 files changed, 16 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> >> index f2d63745be54..2e654917f535 100644
> >> --- a/drivers/interconnect/qcom/icc-rpmh.c
> >> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> >> @@ -285,13 +285,25 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
> >>  			ret = PTR_ERR(node);
> >>  			goto err_remove_nodes;
> >>  		}
> >> +		qn->id = node->id;
> >>  
> >>  		node->name = qn->name;
> >>  		node->data = qn;
> >>  		icc_node_add(node, provider);
> >>  
> >> -		for (j = 0; j < qn->num_links; j++)
> >> -			icc_link_create(node, qn->links[j]);
> >> +		for (j = 0; j < qn->num_links; j++) {
> >> +			struct qcom_icc_node *qn_link_node = qn->link_nodes[j];
> >> +			struct icc_node *link_node;
> >> +
> >> +			if (qn_link_node) {
> >> +				link_node = icc_node_create(qn_link_node->id);
> >> +				qn_link_node->id = link_node->id;
> >> +				icc_link_create(node, qn_link_node->id);
> > 
> > I really don't like the idea of reading the ->id back. I think in the
> > last cycle I have already asked to add an API to link two nodes instead
> > of linking a node and an ID. Is there an issue with such an API?
> 
> Yes, the link pointer may or may not be initialized during the link
> creation as the link can belong to other provider which is yet to probe.
> So, it is not possible to pass two node pointers as arguments for linking.

Obviously, this needs to be handled. e.g. by specifying external
provider + ID from dt-bindings. Yes, it requires a thought on how to
solve it properly. No, in my opinion, reading the ID back is not a
viable option. Ideally after converting to dynamic IDs we should be able
to declare the ID to be an internal detail, which is of no concern to
ICC providers (or even drop it completely). Historically we have had
several subsystems which were using single-list IDs. Most of them have
migrated from using those IDs.

> RPMh driver has multiple providers and during the creation of links,
> nodes associated with other providers are created in the icc_link_create
> API. When the actual provider to which the link belongs is probed, its
> initialization/node creation is skipped by checking the ID. To ensure
> proper tracking of node initialization and prevent re-initialization, it
> is essential to read back and store the node’s ID in qnode.
> 
> 
> > 
> >> +			} else {
> >> +				/* backward compatibility for target using static IDs */
> >> +				icc_link_create(node, qn->links[j]);
> >> +			}
> >> +		}
> >>  
> >>  		data->nodes[i] = node;
> >>  	}
> >> diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
> >> index 82344c734091..cf4aa69c707c 100644
> >> --- a/drivers/interconnect/qcom/icc-rpmh.h
> >> +++ b/drivers/interconnect/qcom/icc-rpmh.h
> >> @@ -95,7 +95,8 @@ struct qcom_icc_qosbox {
> >>  struct qcom_icc_node {
> >>  	const char *name;
> >>  	u16 links[MAX_LINKS];
> >> -	u16 id;
> >> +	struct qcom_icc_node *link_nodes[MAX_LINKS];
> >> +	int id;
> >>  	u16 num_links;
> >>  	u16 channels;
> >>  	u16 buswidth;
> >> -- 
> >> 2.43.0
> >>
> > 
> 

-- 
With best wishes
Dmitry

