Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F22DA18E169
	for <lists+linux-pm@lfdr.de>; Sat, 21 Mar 2020 13:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgCUM51 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Mar 2020 08:57:27 -0400
Received: from mail.manjaro.org ([176.9.38.148]:37516 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgCUM50 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 21 Mar 2020 08:57:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 598A837E507D;
        Sat, 21 Mar 2020 13:57:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o75kpYDVcgR2; Sat, 21 Mar 2020 13:57:23 +0100 (CET)
Subject: Re: [PATCH v5 2/3] dt-bindings: power: supply: add cw2015_battery
 bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200315191914.118565-1-t.schramm@manjaro.org>
 <20200315191914.118565-3-t.schramm@manjaro.org>
 <20200320223108.GB32311@bogus>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <05c068f5-9621-9879-b500-0a2dc242eefb@manjaro.org>
Date:   Sat, 21 Mar 2020 13:57:38 +0100
MIME-Version: 1.0
In-Reply-To: <20200320223108.GB32311@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

thanks for the review. I've just sent out v6 addressing the issues you
have found.

Tobias

