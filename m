Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1EA216EA77
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 16:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgBYPs7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 10:48:59 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:62505 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729537AbgBYPs7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 10:48:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582645738; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=K8JRAAUqIiBv8eRLCyrJkO1Q8E5vnb4MRUaWxR0NqEE=;
 b=O1eHm17rfz2yh0A5tZ2z1GnSRiDq23ZGefb/ZNFj7FbFEvne+IdWgrAjNvzRDOuEI9IwihfF
 vS9FAp3+8TSRTCLiamqaAKTXr0cvVVhgk09P9GdcqO4Zti1AQ8304TdncyI46pIzoAh5QEJ0
 iD87Y5/EItZunWf9xQxCaEL/bXY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e5541ea.7fb06ae4d810-smtp-out-n01;
 Tue, 25 Feb 2020 15:48:58 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E4F34C447A2; Tue, 25 Feb 2020 15:48:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52814C447A0;
        Tue, 25 Feb 2020 15:48:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Feb 2020 21:18:57 +0530
From:   okukatla@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     georgi.djakov@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        ilina@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [V3, 3/3] dt-bindings: interconnect: Add Qualcomm SC7180 DT
 bindings
In-Reply-To: <20200221194012.GF24720@google.com>
References: <1582277450-27382-1-git-send-email-okukatla@codeaurora.org>
 <1582277450-27382-4-git-send-email-okukatla@codeaurora.org>
 <20200221194012.GF24720@google.com>
Message-ID: <3baf11a2cbdb649d6e850aa15665d28f@codeaurora.org>
X-Sender: okukatla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-02-22 01:10, Matthias Kaehlcke wrote:
> Hi Odelu,
> 
>> Subject: dt-bindings: interconnect: Add Qualcomm SC7180 DT bindings
> 
> This patch doesn't add a binding, but DT entries for SC7180.
> 
> The subject of v2 was "arm64: dts: sc7180: Add interconnect provider
> DT nodes", please go back to that or something similar.

Thanks for the review!
Noticed this later, i will address this in next patch.
