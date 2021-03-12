Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2629339062
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 15:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhCLOxu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 09:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhCLOxR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 09:53:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E48C061574;
        Fri, 12 Mar 2021 06:53:17 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:53:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615560789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OAM6or3ARwG/0BYC2kJlO8OCmHDKTa5gLneB2+3VPOI=;
        b=dgMBopnr5ZotSLogjHDnE3WtGpfN2z+gTLoThm90/b+KQN0Bfgs5ZNJtSKvHL1LRINQ1uL
        K/XM6eEDaQ0Md/arz2puagT7D0ZNPiINB5AosaytoXa/tIR/hWC9KEZtm3j1M1QaqDYjEo
        EcJnK3cNIqEl7HGzxi98COnrKvQ5NTxDEXRmb0uO8T0ctbEchyogAyeca9Y9gp+Fmy3xdm
        b3DIK4O0SapxmzkTRGy4vtMlGZX4Tgi7cGAPZbbAIvMFfrki/gJSbSWFBMrYM7QYQCjpIB
        Q43SlR4jlkFo8QJM9yUIIujKKoSSS095vl/kKck0w7+LRd0jrsX+lfBaaja3/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615560789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OAM6or3ARwG/0BYC2kJlO8OCmHDKTa5gLneB2+3VPOI=;
        b=+Ts9bYqQLrk+rgJQq3+qhjDVKQn9Q843mWnyvFCjpZe6xrrsWK+KyEFnjxXUJCXrlXvPfg
        YEdKXpMnxwQCU1Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Timon Baetz <timon.baetz@protonmail.com>, linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sebastian.reichel@collabora.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] extcon: Provide *extcon_*_notifier_all() stubs for
 !CONFIG_EXTCON
Message-ID: <20210312145307.mkzkrbehqertfv3r@linutronix.de>
References: <20210312141051.blqkm2v2yx6psild@linutronix.de>
 <CAJKOXPeXQS2pZ-siZGP+E3y1Gus5_9-ByAetUD9Mk0UH+t0OYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJKOXPeXQS2pZ-siZGP+E3y1Gus5_9-ByAetUD9Mk0UH+t0OYA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-03-12 15:45:48 [+0100], Krzysztof Kozlowski wrote:
> Did you base your work on next?

no, -rc2.

> Best regards,
> Krzysztof

Sebastian
