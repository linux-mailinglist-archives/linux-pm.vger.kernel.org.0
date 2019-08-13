Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C22988C1D5
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 22:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfHMUKB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 16:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfHMUKB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Aug 2019 16:10:01 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D5692067D;
        Tue, 13 Aug 2019 20:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565727000;
        bh=IiCD7IsT67JhzKzMH/tdAui5BDrSXtu3NUCLmNQc6n0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XXoWIRKlGSg9iDPpwqt+n7qPov9+Y81AxhP2IGS5o4ds4+Pf25nRy0LFC8t3z1klw
         Xk+fVp92/JUXpkJShUwE+FrauPx8Ah4KPjQujcJPjhTERhCnnj5oePyrsVsgBbIi/O
         OY6wc0S+N7ESGb6XRuu1kcS5gQF7Jl3V8D8lsqeY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190813184717.GA28465@jcrouse1-lnx.qualcomm.com>
References: <1565037226-1684-1-git-send-email-jcrouse@codeaurora.org> <20190807234232.27AA720880@mail.kernel.org> <20190813184717.GA28465@jcrouse1-lnx.qualcomm.com>
Subject: Re: [PATCH v2] drivers: qcom: Add BCM vote macro to header
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-clk@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Tue, 13 Aug 2019 13:09:59 -0700
Message-Id: <20190813201000.6D5692067D@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Jordan Crouse (2019-08-13 11:47:17)
> On Wed, Aug 07, 2019 at 04:42:31PM -0700, Stephen Boyd wrote:
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
>=20
> I figured this landed in Bjorn's domain, but you guys can fight it out if=
 you
> want.
>=20

Ok. I'm happy to avoid the fight!

