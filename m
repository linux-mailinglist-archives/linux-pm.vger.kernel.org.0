Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB796C22BB
	for <lists+linux-pm@lfdr.de>; Mon, 20 Mar 2023 21:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjCTUcq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Mar 2023 16:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCTUcn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2023 16:32:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00524227AF
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2023 13:32:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87DFCB8100E
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2023 20:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009E1C4339B;
        Mon, 20 Mar 2023 20:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679344349;
        bh=vjDWW1KweG29mfyDiDeL4iDCCPQgc8GyfO1yCDHLcLY=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=LhHIN/niQLPtWMNJAURWcu4UW8ErrCZbbYC8SDdRid2lIiP//IHutRX8UMBXAgTRI
         brksqfe0jJEeY/wBrncqHHgsT6xQJkktf64kUXhD/8BAWbyc8A1v+3SseB6C4n+L8y
         1P6O7o37y8oXXQxcGYXk6m+wQsznnJQ7qphM43QEWvEhsr7gvh5oRRbpUjLgMWdkqJ
         lzgYCV4Km9Qe90mDFRhUx+s81wDvxiZlEtb1dhgqvscPq273T+6uuEgsj6DFPOiFFh
         ly7IrWk0JdcnAOaZt0Ca7o4qmE55Mc9nzkI9ROLbfzsdXoOLSg9h69iI9+8RhzwFLb
         gaLchHCsrA6QQ==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id DDD2127C0054;
        Mon, 20 Mar 2023 16:32:27 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Mon, 20 Mar 2023 16:32:27 -0400
X-ME-Sender: <xms:28IYZB-c12RJsHyNf4krk0lW-VLbjRd7MF1GCorpgfMTR4nWHFaJow>
    <xme:28IYZFtvm7wbJAFALysWD6bZeBNULLev3r5iy6Z8w9qePKVk_dyjoJpV1_jJyE9lz
    DyzO-SNhss2pUOk35c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeej
    ffduhefgteeihfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:28IYZPCDfn3CE0F_Tt5v3GbOOLcX-d6jcadg4TaXrj8bVN9WHnlLqg>
    <xmx:28IYZFc5ix8a56QRIqhZsNmF7xoM_O24iIQgUqKo_mW7WUTk13-AGA>
    <xmx:28IYZGNYQw5p_VmHOLC2eOoEx5Aq2yOft0sVnX6-N8CoJczyrWTc3g>
    <xmx:28IYZPburaoJ-X88jVaUIWNFG8um86P6lrAYtaUoLUsGA5Km5xO_vg>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9838E31A0064; Mon, 20 Mar 2023 16:32:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <551b44ea-b8ac-4769-b858-88f3e3ecbfd4@app.fastmail.com>
In-Reply-To: <05fdea5a-bfad-4d7c-9925-9a45b2882782@app.fastmail.com>
References: <20230310122110.895093-1-dedekind1@gmail.com>
 <20230310122110.895093-4-dedekind1@gmail.com>
 <20230320145034.GM2194297@hirez.programming.kicks-ass.net>
 <05fdea5a-bfad-4d7c-9925-9a45b2882782@app.fastmail.com>
Date:   Mon, 20 Mar 2023 13:32:07 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Artem Bityutskiy" <dedekind1@gmail.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "Linux PM Mailing List" <linux-pm@vger.kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>
Subject: Re: [PATCH v2 3/3] intel_idle: add C0.2 state for Sapphire Rapids Xeon
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 20, 2023, at 11:27 AM, Andy Lutomirski wrote:

> Also, this series needs to be tested on virt.  Because UMWAIT, if it 
> works at all on virt, is going to have all manner of odd concequences 
> due to the fact that the hypervisor hasn't the faintest clue what's 
> going on because there's no feedback.  For all that UiPI is nasty and 
> half-baked, at least it tries to notify the next privilege level up as 
> to what's going on.  Explicit wakeups virtualize much better than 
> cacheline monitors.

Sorry to keep replying to myself.  -ETOOLITTLESLEEP.

This needs more than testing on virt.  It needs explicit documentation and handling of virt so we don't end up using UMWAIT on virt and doing something utterly daft like busy-waiting instead of properly going to sleep and not noticing because few people are actually testing on virt on a CPU that has this ability right now.

(Also, there's a surprising ability to thoroughly break idle without anyone reporting it for an impressively long time.  The system still serves cute cat photos, so it doesn't end up on the dashboard!)
