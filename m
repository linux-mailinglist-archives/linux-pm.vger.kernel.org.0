Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8D07ED899
	for <lists+linux-pm@lfdr.de>; Thu, 16 Nov 2023 01:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjKPAit (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Nov 2023 19:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjKPAis (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2023 19:38:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0900125
        for <linux-pm@vger.kernel.org>; Wed, 15 Nov 2023 16:38:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448A4C433C7;
        Thu, 16 Nov 2023 00:38:45 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
        id 071641062B52; Thu, 16 Nov 2023 01:38:42 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Asmaa Mnebhi <asmaa@nvidia.com>
In-Reply-To: <20231030203058.8056-1-asmaa@nvidia.com>
References: <20231030203058.8056-1-asmaa@nvidia.com>
Subject: Re: [PATCH v1 1/1] power: reset: pwr-mlxbf: support graceful
 reboot instead of emergency reset
Message-Id: <170009512199.785165.15508429690118888227.b4-ty@collabora.com>
Date:   Thu, 16 Nov 2023 01:38:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Mon, 30 Oct 2023 16:30:58 -0400, Asmaa Mnebhi wrote:
> Replace the soft reset with a graceful reboot.
> An acpi event will be triggered by the irq in the pwr-mlxbf.c
> to trigger the graceful reboot.
> 
> 

Applied, thanks!

[1/1] power: reset: pwr-mlxbf: support graceful reboot instead of emergency reset
      commit: b9afaa069e58939d95923c27c2fd76a0523119a7

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

