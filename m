Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B3FAA38A
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2019 14:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbfIEMyo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Sep 2019 08:54:44 -0400
Received: from 9.mo1.mail-out.ovh.net ([178.32.108.172]:59824 "EHLO
        9.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730864AbfIEMyn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Sep 2019 08:54:43 -0400
X-Greylist: delayed 6598 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Sep 2019 08:54:43 EDT
Received: from player778.ha.ovh.net (unknown [10.109.146.131])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id 9510718DED2
        for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2019 12:26:17 +0200 (CEST)
Received: from qperret.net (115.ip-51-255-42.eu [51.255.42.115])
        (Authenticated sender: qperret@qperret.net)
        by player778.ha.ovh.net (Postfix) with ESMTPSA id 9F16B968B125;
        Thu,  5 Sep 2019 10:25:59 +0000 (UTC)
Date:   Thu, 5 Sep 2019 12:25:53 +0200
From:   Quentin Perret <qperret@qperret.net>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Will Deacon <will@kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        catalin.marinas@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        qais.yousef@arm.com
Subject: Re: [PATCH] mailmap: Update email address for Quentin Perret
Message-ID: <20190905102552.GA12097@qperret.net>
References: <20190902105036.32419-1-quentin.perret@arm.com>
 <20190903145950.xko5fejupxj3f5nx@willie-the-truck>
 <20190904144346.396a77f8@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904144346.396a77f8@lwn.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Ovh-Tracer-Id: 16341592727032519557
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejjedgvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Jon,

On Wednesday 04 Sep 2019 at 14:43:46 (-0600), Jonathan Corbet wrote:
> If there's some value to having an entry in the mailmap file, then
> obviously it should be added.

So, FWIW, get_maintainers.pl does return my name as 'author' or 'commit
signer' on few files (include/linux/energy_model.h among others for ex).
Which is why I thought updating .mailmap would be good practice.

Thanks,
Quentin
