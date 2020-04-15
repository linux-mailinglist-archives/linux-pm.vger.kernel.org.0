Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2771AADB2
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 18:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406953AbgDOQSV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Apr 2020 12:18:21 -0400
Received: from mail.manjaro.org ([176.9.38.148]:43786 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729491AbgDOQST (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Apr 2020 12:18:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 119C33A4121D;
        Wed, 15 Apr 2020 18:18:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CP2gW0An3Rr8; Wed, 15 Apr 2020 18:18:13 +0200 (CEST)
Subject: Re: [RESEND v6 2/3] dt-bindings: power: supply: add cw2015_battery
 bindings
To:     Rob Herring <robh@kernel.org>,
        Tobias Schramm <t.schramm@manjaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200414125208.1091989-1-t.schramm@manjaro.org>
 <20200414125208.1091989-3-t.schramm@manjaro.org>
 <20200415145739.GA7406@bogus>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <2161e423-a7b0-0331-4bd1-0bea3fc72d2b@manjaro.org>
Date:   Wed, 15 Apr 2020 18:19:28 +0200
MIME-Version: 1.0
In-Reply-To: <20200415145739.GA7406@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

> Please add Acked-by/Reviewed-by tags when posting new versions.
Ah, sorry. Forgot your Acked-By. This patch should of course have an

Acked-by: Rob Herring <robh@kernel.org>

> However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.

This resend was mostly for inclusion of the driver in mainline. However,
considering the current situation this was probably a little early.

Tobias
