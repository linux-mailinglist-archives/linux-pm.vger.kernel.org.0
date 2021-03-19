Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252FE342022
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 15:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhCSOsr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 10:48:47 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54422 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhCSOsZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 10:48:25 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id cc85d19a4bd52e87; Fri, 19 Mar 2021 15:48:23 +0100
Received: from kreacher.localnet (89-64-81-50.dynamic.chello.pl [89.64.81.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 27668667D8E;
        Fri, 19 Mar 2021 15:48:23 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        "elaine.zhang" <zhangqing@rock-chips.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 0/2] PM: runtime: Update device status before letting suppliers suspend (another take)
Date:   Fri, 19 Mar 2021 15:42:58 +0100
Message-ID: <4641414.31r3eYUQgx@kreacher>
In-Reply-To: <5448054.DvuYhMxLoT@kreacher>
References: <5448054.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudefkedgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedurdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekuddrhedtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepiihhrghnghhqihhnghesrhhotghkqdgthhhiphhsrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, March 18, 2021 7:06:54 PM CET Rafael J. Wysocki wrote:
> Hi All,
> 
> The previous attempt to address the issue tackled by this series, commit
> 44cc89f76464 ("PM: runtime: Update device status before letting suppliers
> suspend") was incorrect, because it introduced a rather nasty race condition
> into __rpm_callback(), so let's revert it (patch [1/2]).
> 
> Instead, let's avoid suspending the suppliers immediately after dropping the
> PM-runtime references to them and do that later, when the status of the
> consumer has changed to RPM_SUSPENDED.
> 
> Please see the patch changelogs for details.
> 
> Elaine, please test this series on the system where you saw the original
> problem.

The above still applies.

The v2 is sent because of some updates in the second patch, plus the tags from Ulf.

Thanks!



