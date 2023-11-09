Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353D77E6CF6
	for <lists+linux-pm@lfdr.de>; Thu,  9 Nov 2023 16:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjKIPLw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Nov 2023 10:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbjKIPLu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Nov 2023 10:11:50 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FB435B1
        for <linux-pm@vger.kernel.org>; Thu,  9 Nov 2023 07:11:47 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1cc5b705769so9067175ad.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Nov 2023 07:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699542707; x=1700147507; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfO0vj2nASWy3ReruduhK0+7yDo2Je44FrP4T9dAGIU=;
        b=DtxNJCi0NXxIBo/YhztjL6nMVYgap3UdLr0Xwt7vTNqW5Fw/3CGrNxzcuNqOEVgiJT
         vp2/UqG1BR05qcccdeZS5Rb6jOcP1UInpjYmcOlEmuPKYn+OCYywguPFt5Rt0lUWHrnu
         GDtTdJztzGDHQSEH6rAWv67MfqF36c6vE8RiplxfxE7xX6Y5Dwoz5VORGbZKD9i9sRde
         t8DNf4cvNPbYy0hpfkKfj0oxo/bXXtjHfEMBDZiN2MdZ2kP1V5I5WcwVcdVu/6wzpuvi
         4wEx36Fe5X+7tpSU21mok/92V7Et4VkGpy0sxhDy6gL8yhiTsE6dKy+C1E+uGKypeVQ/
         K2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699542707; x=1700147507;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfO0vj2nASWy3ReruduhK0+7yDo2Je44FrP4T9dAGIU=;
        b=mKs3MeQvekHDAclZfTmO1khh1RYaJmRgxYeqI4F3rmlIYjNaJGxwf1C/VYYAWWLZZ8
         /gdaOgXmyi6qZqY0l7+5zhhmFNPWLvf+KlWuuX9YBfElcX5CTn+UVeMSnh7IKrgm3vF8
         MrJljwXaPkyZe9coTMGsoOFOOTqcG25HVt8gVJqcW8mSPM+U9/ua0WfVYDrEsylYdf1V
         5K5L70qyqEF2N82K0dvaasnYjIy3nM0N9wjtKnHBupSGPrrffSLAYPXDCXPegIQR4Wla
         AHSiDsWDXxUL2W8II8UQNJCyoTJrOg7buBkRYKwoCp0IV6l+3ogwfR+bAykCzOmFPFBo
         uZog==
X-Gm-Message-State: AOJu0YxFWOV+DEfOEbxcdyNFmrubX75JzAdciCrCKGEzstgXIXKxpqE9
        f+3WvCNB+han2XJ1cWFxXhNBXVXqWua2RmrrXQ==
X-Google-Smtp-Source: AGHT+IGaAXooCMKKCV105U9Hteo6inqeahtRFXRa3XeLWlJieHM2isS+qasQkQi8m5SRPa3mommNhCc9W3kI4ZrUmPg=
X-Received: by 2002:a17:903:4281:b0:1cc:68c1:cab5 with SMTP id
 ju1-20020a170903428100b001cc68c1cab5mr5002521plb.14.1699542707259; Thu, 09
 Nov 2023 07:11:47 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:902:8c98:b0:1cc:2be6:281d with HTTP; Thu, 9 Nov 2023
 07:11:46 -0800 (PST)
Reply-To: mrskathleens37@gmail.com
From:   "Mrs. Gottfried S. Kathleen" <mrsmarois329@gmail.com>
Date:   Thu, 9 Nov 2023 07:11:46 -0800
Message-ID: <CADzi4QRorJEN1swjY-+LGs46YHbvUfby3q+MNAuWtCQkQDp7cg@mail.gmail.com>
Subject: I am Mrs. Gottfried S. Kathleen
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dearest Beloved.

I am Mrs. Gottfried S. Kathleen, I decided to donate what I have to
you for investment towards the good work of charity organizations, and
also to help the motherless and the less privileged ones and to carry
out charitable works in your Country and around the World on my
Behalf.

I am diagnosing of throat Cancer, hospitalize for good 2 years and
some months now and quite obvious that I have few days to live, and I
am a Widow no child,  I decided to will/donate the sum of $7.8 Million
to you for the good work of God, and also to help the motherless
endless privilege and also forth assistance of the widows,  at the
moment I cannot take any telephone calls right now due to the fact
that my relatives (that have squandered the funds for this purpose
before) are around me and my health status also, I have adjusted my
will and my Bank is aware.

I have willed those properties to you by quoting my Personal File
Routing and Account Information. And I have also notified the bank
that I am willing to give that property to you for good effective and
prudent work, It is right to say that I have been directed to do this
by God, I will be going in for a surgery soon and I want to make sure
that I make this donation before undergoing this surgery.

I will need your support to make this dream come through, could you
let me know your interest to enable me to give you further
information.

Thank you once again and warm regards.
Yours Sick Sister in Christ.
Mrs. Gottfried S. Kathleen
