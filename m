Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C21B94CCD
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 20:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfHSS04 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 14:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbfHSS0z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Aug 2019 14:26:55 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A950222CF6;
        Mon, 19 Aug 2019 18:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566239214;
        bh=Ivyitg0Ej4OT9+wlNtHSfddysy0Yzo6f+ai2y1gszXo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=yKwuiNEaKXSYTOZwJLHBcizgkZa/S9//ofj0LoEwmolfjTUp76LpNj7X/Gw2u9OVT
         lA2rQ2cnpzqET0Sj2IWzg0jTiYtu6cz3rBpDG/h5df4HVfJVWcUGMAydFgak4HldCg
         yjvbx6h0fC4neMZWruWmN2spKfWn+0bAiGb0txB4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190819165255.GA26807@tuxbook-pro>
References: <1565037226-1684-1-git-send-email-jcrouse@codeaurora.org> <20190807234232.27AA720880@mail.kernel.org> <20190819165255.GA26807@tuxbook-pro>
Subject: Re: [PATCH v2] drivers: qcom: Add BCM vote macro to header
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-clk@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
User-Agent: alot/0.8.1
Date:   Mon, 19 Aug 2019 11:26:53 -0700
Message-Id: <20190819182654.A950222CF6@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Bjorn Andersson (2019-08-19 09:52:55)
> On Wed 07 Aug 16:42 PDT 2019, Stephen Boyd wrote:
>=20
> > Quoting Jordan Crouse (2019-08-05 13:33:46)
> > > The macro to generate a Bus Controller Manager (BCM) TCS command is u=
sed
> > > by the interconnect driver but might also be interesting to other
> > > drivers that need to construct TCS commands for sub processors so move
> > > it out of the sdm845 specific file and into the header.
> > >=20
> > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > ---
> >=20
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
> >=20
> > Unless this is supposed to be applied by me?
> >=20
> > BTW, I wonder why we need an rpm clk driver much at all nowadays, except
> > maybe for the XO clk state. The big user, from what I can tell, is the
> > interconnect driver and we don't use any of the features of the clk
> > framework besides the API to set a frequency. Maybe it would be better
> > to just push push the bus frequency logic into interconnect code, then
> > XO clk is the only thing we need to keep, and it can be a simple on/off
> > thing.
> >=20
>=20
> There's been a number of cases where we'll need to enable the buffered
> XOs, but perhaps these are handled by other subsystems these days(?)
>=20
> If so the one case that remains would be the operation of explicitly
> holding CXO enabled during operations such as booting the remoteprocs.
>=20

Yes I think the XO (and the buffers) is the only thing that we really
seem to care about for the clk tree. Otherwise, the sole user is
interconnect code and thus handling it in the rpmh clk driver doesn't
really gain us anything. In fact, it just makes it worse because it ties
the clk tree up with things that could take a while to process on the
RPM side.

