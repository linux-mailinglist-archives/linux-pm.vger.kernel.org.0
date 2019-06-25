Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC27F55BFB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 01:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFYXEy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 19:04:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFYXEy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jun 2019 19:04:54 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB3AE2133F;
        Tue, 25 Jun 2019 23:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561503893;
        bh=L4wBBj7VYpmL0ZQhlGCEppLooGryYJZoy3g3fIHaeIE=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=PBoK/RHe3VYSOdqx4mIrnN2ixf4WZrCYkKciUyfXafKP7cRof0QJmGYPT5sBTNjmR
         e9EWck1IuKdqMSSv95Fb7sIPbpf2ptBaYyu1fe30IYP161d3abwLoYncRFeTrkW2wz
         +tzY9h+O9ZM6B28REljVYnBg0ldQgAUDE1PJHJvs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190612182500.4097-3-nsaenzjulienne@suse.de>
References: <20190612182500.4097-1-nsaenzjulienne@suse.de> <20190612182500.4097-3-nsaenzjulienne@suse.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, stefan.wahren@i2se.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 2/7] clk: bcm283x: add driver interfacing with Raspberry Pi's firmware
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        eric@anholt.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 16:04:51 -0700
Message-Id: <20190625230452.EB3AE2133F@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Nicolas Saenz Julienne (2019-06-12 11:24:54)
> Raspberry Pi's firmware offers an interface though which update it's
> clock's frequencies. This is specially useful in order to change the CPU
> clock (pllb_arm) which is 'owned' by the firmware and we're unable to
> scale using the register interface provided by clk-bcm2835.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Acked-by: Eric Anholt <eric@anholt.net>
> ---

Applied to clk-next

