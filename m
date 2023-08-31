Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A2278F164
	for <lists+linux-pm@lfdr.de>; Thu, 31 Aug 2023 18:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbjHaQj2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Aug 2023 12:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjHaQj1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2023 12:39:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA943122;
        Thu, 31 Aug 2023 09:39:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E8B1621D8;
        Thu, 31 Aug 2023 16:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77650C433C7;
        Thu, 31 Aug 2023 16:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693499963;
        bh=g8xLY/dzEhuIK4x27Q6kJp7C/0Jbe5J3zYO8mO/3aC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KIZpr6ENwLVYu0b/XguiTaTDDJHKPva0+/8B88VGItwawLNOyx4Hfl5896MEX7d6w
         ReQR2sCItxRwB06NhAJFeHbW9n+Uy8CSNf57rq6HdWAAAGD82rCmQYCE8AI1Guh7Lo
         ije1As5khU1WFEVFi3t5Gti36BhXnQB0GFnEwSTDtoT05nIEq2D26hzDYRlHaBRToS
         VphFx+9si+yELUYmEnPffgBQa8P/LU7A4vbBocNLgwGKwDc2oIBg49RjOr/nvc89rK
         sajQ6XHmb46wrCERHvzaz9xVRg6B46n7eyJ7dl/CWhB5XoYnH9eyJNElqdoQ1gcR2/
         P2X9e7ntOo9qw==
Received: (nullmailer pid 2406856 invoked by uid 1000);
        Thu, 31 Aug 2023 16:39:21 -0000
Date:   Thu, 31 Aug 2023 11:39:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Binbin Zhou <zhoubb.aaron@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev
Subject: Re: [PATCH 2/5] dt-bindings: soc: loongson,ls2k-pmc: Add missing
 compatible for Loongson-2K2000
Message-ID: <20230831163921.GA2393252-robh@kernel.org>
References: <cover.1693218539.git.zhoubinbin@loongson.cn>
 <54ee114c08f35ab8b5dc584fd76135ac9076f5a7.1693218539.git.zhoubinbin@loongson.cn>
 <20230828-shrewdly-payee-c5eb091a0417@spud>
 <CAMpQs4Jp0rb8sbrLrPnNziLph4Ym4LxBsFt-00G69ecd8bUHNg@mail.gmail.com>
 <3fd27e64-2221-ec38-1320-9ae966f998aa@linaro.org>
 <CAMpQs4+W1q0XziBVXr12xpFW=u2EkZx-_b-Mppx7cZukZLOBCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpQs4+W1q0XziBVXr12xpFW=u2EkZx-_b-Mppx7cZukZLOBCQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 29, 2023 at 02:52:48PM +0800, Binbin Zhou wrote:
> On Tue, Aug 29, 2023 at 2:29 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 29/08/2023 05:21, Binbin Zhou wrote:
> > > HI Conor:
> > >
> > > Thanks for your reply.
> > >
> > > On Mon, Aug 28, 2023 at 11:49 PM Conor Dooley <conor@kernel.org> wrote:
> > >>
> > >> On Mon, Aug 28, 2023 at 08:38:32PM +0800, Binbin Zhou wrote:
> > >>> Document the Power Management Unit system controller compatible for
> > >>> Loongson-2K2000.
> > >>>
> > >>> This is a missing compatible, now we add it.
> > >>>
> > >>> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > >>> ---
> > >>>  .../devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml      | 1 +
> > >>>  1 file changed, 1 insertion(+)
> > >>>
> > >>> diff --git a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
> > >>> index da2dcfeebf12..7473c5659929 100644
> > >>> --- a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
> > >>> +++ b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
> > >>> @@ -15,6 +15,7 @@ properties:
> > >>>        - enum:
> > >>>            - loongson,ls2k0500-pmc
> > >>>            - loongson,ls2k1000-pmc
> > >>> +          - loongson,ls2k2000-pmc
> > >>
> > >> Same thing here as the driver patch, the pmc on this newly added SoC
> > >> appears to use the same codepaths as the existing ones. Does it share a
> > >> programming model & should there be a fallback compatible here?
> > >
> > > I noticed the guideline about fallback compatible:
> > >
> > > "DO use fallback compatibles when devices are the same as or a subset
> > > of prior implementations."
> > >
> > > But in fact, ls2k0500/ls2k1000/ls2k2000 are independent, there is no subset.
> >
> > We do not consider here ls2k0500/ls2k1000/ls2k2000, but PMC in each of
> > them. If they are independent, why would they use the same interface?
> 
> Sorry. I may have misunderstood.
> The "subset" in the above guideline, here we should be talking about
> PMC, not SoC.
> For PMC, ls2k0500/ls2k1000/ls2k2000 are the same.
> 
> Am I understanding correctly now?

The test is can an OS/client which only understands the fallback 
compatible (loongson,ls2k-pmc) use that h/w block (or some subset of 
it)? If so, then a fallback is appropriate. If not, then don't use a 
fallback. If the block in one SoC is a proper subset of another SoC, 
then make the compatible that's a subset the fallback. However, that's 
really only helpful if an OS/client already understands the fallback. 


> Also, when I said "independent" above, I meant they are three different SoCs.

But those SoCs are probably not designed completely independently. An 
existing SoC is the basis for the next SoC design.

OTOH, things like pinmux, clocks, power mgt, etc. tend to change in 
every chip.

Rob
