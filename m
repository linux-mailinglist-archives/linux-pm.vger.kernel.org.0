Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9BC61947A
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 23:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfEIVTd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 17:19:33 -0400
Received: from shell.v3.sk ([90.176.6.54]:45793 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfEIVTd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 May 2019 17:19:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 87AC157F2F;
        Thu,  9 May 2019 23:19:29 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WNVEbJpypCNC; Thu,  9 May 2019 23:19:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2356210402A;
        Thu,  9 May 2019 23:19:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vX4J2-G93UxT; Thu,  9 May 2019 23:19:16 +0200 (CEST)
Received: from furthur.local (g-server-2.ign.cz [91.219.240.2])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 54F1857F2F;
        Thu,  9 May 2019 23:19:16 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        James Cameron <quozl@laptop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH RFC] Enable the GPU on MMP2
Date:   Thu,  9 May 2019 23:19:04 +0200
Message-Id: <20190509211911.17998-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This patch makes the Vivante GC860 GPU work on MMP2 based platforms,
such as the OLPC XO-1.75 laptop.

The reason I'm sending this out as and RFC is to get the opinions on the
power domain use and in particular the patch [5/7] that implements one:

Apart from just enabling the power bits, the power_on() procedure also
turns the clocks on and disables isolation -- if this is not done in
this particular order with the delays in between all sorts of mayhem
ensue. Is this sort of thing acceptable? Is there a better way the
isolation bit is turned off once both of the clocks are running?

Also, it doesn't seem to be possible to turn off the block once it has
been turned on. I guess this is not too cool; but I don't see better
options. Not turning the block on util the GPU driver asks for it still
seems like a better idea than unconditionally enabling it in platform
code, even if it can't be turned off afterwards.

Thanks
Lubo


