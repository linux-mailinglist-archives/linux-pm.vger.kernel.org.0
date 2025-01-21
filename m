Return-Path: <linux-pm+bounces-20757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A37A17A77
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 10:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAFB07A2E19
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 09:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33D31C3C04;
	Tue, 21 Jan 2025 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFw3hIUx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29CC1B3950;
	Tue, 21 Jan 2025 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452832; cv=none; b=Y+HUlObTKV/f9/TANVQAb3HklLSWyKs/zMgwsjBzxfYfTRVPuPW7AC97x52bxyoMjREzsPwfZ1MrP0kdnCh+M9s34zHOsOxR8h8DC9LZoClWMdPcTmV7O0p9WXgYeiLcA0vSUmv3YIYFd2LKfVD1Qv7orqqNHBXkMPKhMAvsHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452832; c=relaxed/simple;
	bh=gOL40yEr1/NPatRuvUJBWXcIzOUAyp06nqREo6aK9zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWQc36HNqhX5DLhO4uMRqqwwRwZx3aHdomaQ8OP/8mX/3Mi5fkI/sjuYWkJT18RFa7bE1p81gyzP6+VesXih1oD5Kl5zilFmpYsRTNnreOCkqSd2KhFVXveyH+20y81Lx0ls4xE/LoojY/qNl3qvZ+KgldP1ukqOfMBjBAuzIJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFw3hIUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFCAC4CEDF;
	Tue, 21 Jan 2025 09:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737452832;
	bh=gOL40yEr1/NPatRuvUJBWXcIzOUAyp06nqREo6aK9zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFw3hIUxRpB0pMNWW0ecfvl/6pcMDQLWAHAlTacL7xDYfmxnfuC2GgHgmQtGA7lA/
	 HJOeo177MwbuT8NRlE5PllCCq85/rUPQFQig62PxdRqJrgvkTAVu2CssMFUkaT1oNX
	 5hyF7ug7CtXd3SZWU/NKZN4QfJkaErG6w1aIqu/zSnzKIRUpfzpgu4KQrrI/bFNWbZ
	 NTC/bMqfhPAhj4hkrtbE7q+PknOLGSPlUWMPT9Ju3401Mnl1SRtydWjtFuBcCKS3dR
	 M9Y8x32vW601rin/e5SpoULr1kgQU+1jVQPYtgOpe0keb4APlUOx8lmu94YtAq67/0
	 ocYLgz1JQbhzw==
Date: Tue, 21 Jan 2025 10:47:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org, 
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com, 
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, ulf.hansson@linaro.org, 
	jszhang@kernel.org, p.zabel@pengutronix.de, m.szyprowski@samsung.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [RFC v3 01/18] dt-bindings: clock: Add VO subsystem clock
 controller support
Message-ID: <20250121-raptor-of-terrific-perfection-cafc27@krzk-bin>
References: <20250120172111.3492708-1-m.wilczynski@samsung.com>
 <CGME20250120172120eucas1p23993cdbbe65e82054b9cb92fb704103b@eucas1p2.samsung.com>
 <20250120172111.3492708-2-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250120172111.3492708-2-m.wilczynski@samsung.com>

On Mon, Jan 20, 2025 at 06:20:54PM +0100, Michal Wilczynski wrote:
>  properties:
>    compatible:
> -    const: thead,th1520-clk-ap
> +    enum:
> +      - thead,th1520-clk-ap
> +      - thead,th1520-clk-vo
>  
>    reg:
>      maxItems: 1
>  
>    clocks:
>      items:
> -      - description: main oscillator (24MHz)
> +      - description: main oscillator (24MHz) or CLK_VIDEO_PLL

thead,th1520-clk-ap gets also VIDEO_PLL? Aren't both serving the same
purpose from these devices point of view? Bindings are telling what this
device is expecting.

>  
>    "#clock-cells":
>      const: 1
> @@ -51,3 +54,10 @@ examples:
>          clocks = <&osc>;
>          #clock-cells = <1>;
>      };
> +
> +    clock-controller@ff010000 {
> +        compatible = "thead,th1520-clk-vo";

Difference in one property does not justify new example. If there is
goign to be resend, just drop.


> +        reg = <0xff010000 0x1000>;
> +        clocks = <&clk CLK_VIDEO_PLL>;
> +        #clock-cells = <1>;

Best regards,
Krzysztof


