Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7796541C9E5
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 18:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344633AbhI2QRh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 12:17:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344370AbhI2QRg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Sep 2021 12:17:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BAA36159A;
        Wed, 29 Sep 2021 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632932155;
        bh=H5neb6N3WRD0QZsTS4TXGrhZW5bcsc1U+11pBkauehk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=uAFGBbyAgcoYhVL3s8v9tZWsyEtpaupmpLzpnXpProoxVyi+fDbcWDMJXhEYzEUmy
         ymCrSnxJ7m7FXWB5RjMF+OEQFoQHaSQCvKU1dHODKit3plzRHWJub9I5luUa8Il9Rm
         aAgA15mQBUExMfX0TUrGSnU+ALNqUijWZHkYq1eLtXix3JI8fylbYHMIY5/mRdkUhN
         jDec0lObYGX2SKskz/UwaYfOoQqTAXrdTkMFTJBmD1vv6uF5iu7ity9DbGM9QoX2Qz
         MsS+5Ns/rsLm95S//llNZ8JW97vFEEmRNa/HshjcBuZ8U/EElEMRhwMZycHicbusr0
         FoEeTXKgAhVgg==
From:   SeongJae Park <sj@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     SeongJae Park <sj@kernel.org>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: core: Fix a build failure due to psy_has_property() definition location
Date:   Wed, 29 Sep 2021 16:15:53 +0000
Message-Id: <20210929161553.26986-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YVSO1NYeegW/trvr@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 29 Sep 2021 09:05:40 -0700 Matthias Kaehlcke <mka@chromium.org> wrote:

> Hi SeongJae,
> 
> thanks for the fix!
> 
> Geert sent a similar patch earlier:
> 
> https://patchwork.kernel.org/project/linux-pm/patch/7b35a74f2c2ad19c8dc1ca60c59e48a14288677f.1632830348.git.geert+renesas@glider.be/

No problem, good to hear that!


Thanks,
SJ

[...]
