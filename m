Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8BD6F3A9D
	for <lists+linux-pm@lfdr.de>; Tue,  2 May 2023 00:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjEAWpC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 May 2023 18:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjEAWpB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2023 18:45:01 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610061FDD
        for <linux-pm@vger.kernel.org>; Mon,  1 May 2023 15:45:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-528dd896165so1502023a12.2
        for <linux-pm@vger.kernel.org>; Mon, 01 May 2023 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682981100; x=1685573100;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OQB6iNKkO4+y/9ieUCeGj1Y58XqXg5k4s4FKmjy7sc=;
        b=4KDaiO6LisTYLT/TMV+oW0SlgxHJuKfLtpmqI92q2ZRpt4enwVBFhEDSKsuv5bhoLS
         fOGzlpM359VrlHKC86rq5jD4shsPMnm2QEFNdXVZ52oacbI3u8Ld+v3eeVfv7mlF/beV
         Io5Zp1RXghjwmd4bCP9KS+Z3NCInXlMqcLIYfz5fBA0OHV0tX4BFL0NB3LxjNmcTx53Q
         YDiu7icXGBhsbgQ299UJ+udPCmd6qNnk4elkz3jpRtF4PUV/WmzRjsULt7PRDRvexNsE
         rjRa87S6ZzSESGtFLtmtx6NEAm+rp/2ixnPeTMKo8RTpYSlJR+ParJtAK9HVDSvvVFC9
         C/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682981100; x=1685573100;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OQB6iNKkO4+y/9ieUCeGj1Y58XqXg5k4s4FKmjy7sc=;
        b=co+aEnFva3FsPruOFpuatgWJ6aakK/htoUfFcnQbgtwA1Y5EJJmbzqw1ZEl/b7UwWN
         s2/bg2x/OfyzpnGriBIezFvDXKfFX6i+/66GUJ+KYyyDEcO9g3b+K2+FGrJM4zkyrgea
         V9EHDY/t/OANQVvNfyNHTpp5MjS7H8soIWIJOfKc6mLLE6LnpzE3VHGTsb+5Dz9wmBy1
         hLYVOpikCz8PlSBw67Kjle2lO5Ug6JPEuTAhrXjxZEBwo4oZWA1oxces8ZlKZOP/I4uS
         bhhqa0AXSnf8wmpr1xx6AJIHJk7H7P1FWdnZUy96Jc+3gXmVHqBWtcSeNPVdEf57ZiLg
         55mA==
X-Gm-Message-State: AC+VfDw+lCRl5NrILPdCXYhLMVgmTeZrNpLUOrRdFU2K/5I+W2z2nygz
        MSzHhN70eBB6LikQk3YowAxjKw==
X-Google-Smtp-Source: ACHHUZ7uy00k2USN1lzmV5AsdHPtzc5Q0FuQEmXxK9cV9XA1tn/I1mSKAP4YeiluCRIOkTtjzeEmVw==
X-Received: by 2002:a17:903:22c9:b0:1a8:1867:1f71 with SMTP id y9-20020a17090322c900b001a818671f71mr18923506plg.41.1682981099840;
        Mon, 01 May 2023 15:44:59 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902789700b0019ee045a2b3sm18262780pll.308.2023.05.01.15.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:44:59 -0700 (PDT)
In-Reply-To: <20230427163626.101042-1-ajones@ventanamicro.com>
References: <20230427163626.101042-1-ajones@ventanamicro.com>
Subject: Re: [PATCH v2] RISC-V: Align SBI probe implementation with spec
Message-Id: <168298107617.32296.1350302899241039554.b4-ty@rivosinc.com>
Date:   Mon, 01 May 2023 15:44:36 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     "'Rafael J . Wysocki '" <rafael@kernel.org>,
        'Atish Patra ' <atishp@atishpatra.org>,
        'Mark Rutland ' <mark.rutland@arm.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        'Albert Ou ' <aou@eecs.berkeley.edu>,
        'Palmer Dabbelt ' <palmer@dabbelt.com>,
        'Will Deacon ' <will@kernel.org>,
        'Daniel Lezcano ' <daniel.lezcano@linaro.org>,
        'Paul Walmsley ' <paul.walmsley@sifive.com>,
        'Anup Patel ' <anup@brainfault.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        kvm-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Thu, 27 Apr 2023 18:36:26 +0200, Andrew Jones wrote:
> sbi_probe_extension() is specified with "Returns 0 if the given SBI
> extension ID (EID) is not available, or 1 if it is available unless
> defined as any other non-zero value by the implementation."
> Additionally, sbiret.value is a long. Fix the implementation to
> ensure any nonzero long value is considered a success, rather
> than only positive int values.
> 
> [...]

Applied, thanks!

[1/1] RISC-V: Align SBI probe implementation with spec
      https://git.kernel.org/palmer/c/41cad8284d5e

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

