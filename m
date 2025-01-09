Return-Path: <linux-pm+bounces-20163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D905BA082F8
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 23:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B45188BB40
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 22:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DE5205E07;
	Thu,  9 Jan 2025 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsYDOCEr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735A02054E3;
	Thu,  9 Jan 2025 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736463194; cv=none; b=Q3nbHMhRILwFt8qTV1n7FuTpfFCPG8KvODyCeTgPwhqk68JRx0g0NBRnn4fvOfXDTdWXULfcM6B2wCPGfmY0URbr8ONlc/dCPt8K/JZ6lhwg0FmWzzHRhhmt1RA+zt20r+5IEgcX+nrUax+36ei5A3Heayzt8YsgxjEajjAzMKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736463194; c=relaxed/simple;
	bh=ygPBiRPZBdHE0lhMQk0UMilxxye1rAgfC0lt552dW+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2nDoL58GOJ2kgPohFW/aPdtZL0EOmgfTQe+LzW0cOZv+Dnlg+GYVVtbPXwu3vYL4wanOBVIFV79FzcEOab3RPes8Xi6wIf2Ag2H1KLMKhLwKAIR7bsczVKYcTnTxBbobKbjW3C7NcsqYAN7OIoEkogx3/sgMcMA/weLOYmq/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsYDOCEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C15C4CED2;
	Thu,  9 Jan 2025 22:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736463194;
	bh=ygPBiRPZBdHE0lhMQk0UMilxxye1rAgfC0lt552dW+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CsYDOCEru3+AEdwiKyVkWO1mOJHA55tzrKUnUNyTndawph6pOFrhOW2l5pojnvJNg
	 XORMOFZhafzHRheJC4Iv5aiLfQ1VqP7MH4Pqu9XdMOpqsE4WY98zwSIMgV4mneTs4v
	 MSH1YspqDd9RCndarix0IjsiR7dityj4eKCyBBD+T6WcvBFrqeyyEK21WNNwg+2OY3
	 /uZxAB7095zODtu0FbcRODsUwetcSBxBU5PkfCNtgydf+hjYcotb4iZsTCuTmqvl91
	 mF8CF65TskxLdd9bruSw13e/03ANgi57eGbjP06pOzhD91/3VFwUjLrJXUYA5XPxxE
	 GHhEzoYh6bnYQ==
Date: Thu, 9 Jan 2025 16:53:12 -0600
From: Rob Herring <robh@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Cody Eksal <masterr3c0rd@epochal.quest>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
	Parthiban <parthiban@linumiz.com>,
	Andre Przywara <andre.przywara@arm.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 12/13] cpufreq: sun50i: add a100 cpufreq support
Message-ID: <20250109225312.GA434678-robh@kernel.org>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
 <20241031070232.1793078-13-masterr3c0rd@epochal.quest>
 <20241111041311.hleaz5fgipsyxigm@vireshk-i7>
 <CAGb2v646NHFAni=P+iC8OZsWMpg0PJc=kYbuWaY=C0-W-q6qAw@mail.gmail.com>
 <20241111055504.2f3szrd5ahudvtqm@vireshk-i7>
 <CAL_JsqJJ5A+nYKg1aU5zqGZsmtNJxpS3Gw04pSH-3xOkQ9Vzew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJJ5A+nYKg1aU5zqGZsmtNJxpS3Gw04pSH-3xOkQ9Vzew@mail.gmail.com>

On Mon, Nov 18, 2024 at 09:36:37AM -0600, Rob Herring wrote:
> On Sun, Nov 10, 2024 at 11:55 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 11-11-24, 13:30, Chen-Yu Tsai wrote:
> > > On Mon, Nov 11, 2024 at 12:13 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 31-10-24, 04:02, Cody Eksal wrote:
> > > > > From: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> > > > >
> > > > > Let's add cpufreq nvmem based for allwinner a100 soc. It's similar to h6,
> > > > > let us use efuse_xlate to extract the differentiated part.
> > > > >
> > > > > Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> > > > > [masterr3c0rd@epochal.quest: add A100 to opp_match_list]
> > > > > Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> > > > > ---
> > > > > Changes in V2:
> > > > >  - Add the A100 to the cpufreq-dt-platdev blacklist.
> > > >
> > > > Can this be applied to the cpufreq tree separately ?
> > >
> > > Yes.
> > >
> > > Acked-by: Chen-Yu Tsai <wens@csie.org>
> >
> > Applied. Thanks.
> 
> You missed the binding patch, so
> "allwinner,sun50i-a100-operating-points" is undocumented. Can you pick
> that up please.

Still not applied, so I applied it.

Rob

