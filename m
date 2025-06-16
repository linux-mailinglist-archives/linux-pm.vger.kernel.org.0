Return-Path: <linux-pm+bounces-28843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE765ADB74E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 18:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1A6F7A3407
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 16:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E75127E047;
	Mon, 16 Jun 2025 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrLy4Y78"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A4B2BEFE1;
	Mon, 16 Jun 2025 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750092487; cv=none; b=b7rl6Fl0SKgCGFEY/arudogtSQqthkR6OYZZ6qAT8ua9e35Uv4v9PSCpxeTgSxGZ8M0e/mHc8JedwK1hO4hFyJnHLemTN9ecHtYwXgPizn+Y5wZzcDo0yA6fpNgdh/NoqqJa2xZk+0xcTSJvnkW6a6Y0X4z27Csv1bmgThfwKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750092487; c=relaxed/simple;
	bh=vhZVzII3CTfFCsNaHspYbWSGDD/REfUZxPruFgTiNbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc1Sy3Ny0+qwBx9MTmha0ja5pr7wyF8mgSS2DOEqqJP3tqDLC2Ce1foYU4nFD7qgwQs3ytvHE5b9I79EWpzhtmbtYuEz2VVcTx6S7XAO5NO2jXUTAobiBdiYgxbQNMBq8MQOZzSM+2cRZqDL49AiGXJ7oeni6MnNBuNgVlIf8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrLy4Y78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51EAC4CEEA;
	Mon, 16 Jun 2025 16:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750092485;
	bh=vhZVzII3CTfFCsNaHspYbWSGDD/REfUZxPruFgTiNbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrLy4Y78WdF45DgIA04d6GzEjtLBdJOuzQzc8TS3cPBYJrqvdD4dQFjmAu31g9sjj
	 LElKFh4qj5gs6zQLqeNtg/LZNM8xpZZMDosfM3a/0yzIL+oPRsoyhb51Jn/kFadBXX
	 Bebo2KAm91G1jlgy63aDMYFC8qn4J4+lj8Rw/0rr4SZqB1mLQOI/Cjvg57bIK0ElAz
	 utaZ2+o6sCFUK+2HW2G7xhAxJ9FTDFKl/7sYwyO/Z/6YYo4+Mab1V7tfmjwSIoRHh8
	 XfinTPBQZknPAJK0LIOHLuUnwUWEku8xay8HtSK4Je5aDfJXhT5Twr+elRYzkKM8lL
	 bkKOrjBzNPQxg==
Date: Mon, 16 Jun 2025 17:47:57 +0100
From: Simon Horman <horms@kernel.org>
To: Joy Zou <joy.zou@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Frank Li <frank.li@nxp.com>, Ye Li <ye.li@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
	Aisheng Dong <aisheng.dong@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: Re: [PATCH v5 1/9] dt-bindings: arm: fsl: add i.MX91 11x11 evk
 board
Message-ID: <20250616164757.GC4794@horms.kernel.org>
References: <20250613100255.2131800-1-joy.zou@nxp.com>
 <20250613100255.2131800-2-joy.zou@nxp.com>
 <20250614171642.GU414686@horms.kernel.org>
 <AS4PR04MB93869345F739436917920F59E170A@AS4PR04MB9386.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS4PR04MB93869345F739436917920F59E170A@AS4PR04MB9386.eurprd04.prod.outlook.com>

On Mon, Jun 16, 2025 at 07:42:39AM +0000, Joy Zou wrote:
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: 2025年6月15日 1:17
> > To: Joy Zou <joy.zou@nxp.com>
> > Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; catalin.marinas@arm.com;
> > will@kernel.org; andrew+netdev@lunn.ch; davem@davemloft.net;
> > edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> > mcoquelin.stm32@gmail.com; alexandre.torgue@foss.st.com;
> > ulf.hansson@linaro.org; richardcochran@gmail.com; kernel@pengutronix.de;
> > festevam@gmail.com; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; imx@lists.linux.dev;
> > linux-arm-kernel@lists.infradead.org; netdev@vger.kernel.org;
> > linux-stm32@st-md-mailman.stormreply.com; linux-pm@vger.kernel.org;
> > Frank Li <frank.li@nxp.com>; Ye Li <ye.li@nxp.com>; Jacky Bai
> > <ping.bai@nxp.com>; Peng Fan <peng.fan@nxp.com>; Aisheng Dong
> > <aisheng.dong@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>
> > Subject: Re: [PATCH v5 1/9] dt-bindings: arm: fsl: add i.MX91 11x11 evk
> > board
> > 
> > On Fri, Jun 13, 2025 at 06:02:47PM +0800, Joy Zou wrote:
> > > From: Pengfei Li <pengfei.li_1@nxp.com>
> > >
> > > Add the board imx91-11x11-evk in the binding docuemnt.
> > 
> > nit: document
> Thanks for your comments!
> Will correct it!
> Will use codespell check the patchset.

Good plan. The --codespell option to checkpatch should work well here.

...

