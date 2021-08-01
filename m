Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6EB3DCC4B
	for <lists+linux-pm@lfdr.de>; Sun,  1 Aug 2021 17:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhHAPZR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Aug 2021 11:25:17 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:57695 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbhHAPZQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Aug 2021 11:25:16 -0400
Date:   Sun, 01 Aug 2021 15:24:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1627831504;
        bh=16nvEv+bon6x/+7Yz7u1tvj0wZxqPW/G8QXVHIT774w=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=Ss22HQEf3TMKrY+YWq75UtCQ7rGlI/Zjzywwx2ohk7UiC0JUbhcXTa/hKF579YA+2
         Gn1Q40ehP5n5XHpxkVI6UdX1v51mhh1GOwY0pCkK45dLl804oCG2ncb5EQEXZFyGFZ
         VCmZ4gC4rqRQ5XVz4NDlzejF52EMtnkb1la7An7I=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v2 0/6] interconnect: qcom: Add MSM8996 interconnect driver
Message-ID: <20210801152427.475547-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds a driver for interconnects on MSM8996. This fixes some rar=
e display underflows
and causes a slight heat reduction.

The driver currently supports all NoCs on MSM8996 except a0noc, due to some=
 issues with writing
to its registers.

Changes since v1:
 - Split first patch into 2 patches, one for renaming qcom_icc_set in icc-r=
pmh, and another
   one for the actual commonization.
 - Revert unnecessary move of include line in sdm660.c=20
=20
Yassine Oudjana (6):
  interconnect: qcom: icc-rpmh: Rename qcom_icc_set
  interconnect: qcom: sdm660: Commonize RPM-QoS
  dt-bindings: interconnect: Move SDM660 to a new RPM-QoS file
  interconnect: qcom: Add MSM8996 interconnect provider driver
  dt-bindings: interconnect: Add Qualcomm MSM8996 DT bindings
  arm64: dts: qcom: msm8996: Add interconnect support

 .../{qcom,sdm660.yaml =3D> qcom,rpm-qos.yaml}   |  23 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  84 +++
 drivers/interconnect/qcom/Kconfig             |  14 +-
 drivers/interconnect/qcom/Makefile            |   4 +
 drivers/interconnect/qcom/icc-rpm-qos.c       | 237 ++++++++
 drivers/interconnect/qcom/icc-rpm-qos.h       | 133 ++++
 drivers/interconnect/qcom/icc-rpmh.c          |   6 +-
 drivers/interconnect/qcom/icc-rpmh.h          |   2 +-
 drivers/interconnect/qcom/msm8996.c           | 574 ++++++++++++++++++
 drivers/interconnect/qcom/msm8996.h           | 149 +++++
 drivers/interconnect/qcom/sc7180.c            |   2 +-
 drivers/interconnect/qcom/sc7280.c            |   2 +-
 drivers/interconnect/qcom/sdm660.c            | 343 +----------
 drivers/interconnect/qcom/sdm845.c            |   2 +-
 drivers/interconnect/qcom/sdx55.c             |   2 +-
 drivers/interconnect/qcom/sm8150.c            |   2 +-
 drivers/interconnect/qcom/sm8250.c            |   2 +-
 drivers/interconnect/qcom/sm8350.c            |   2 +-
 .../dt-bindings/interconnect/qcom,msm8996.h   | 163 +++++
 19 files changed, 1389 insertions(+), 357 deletions(-)
 rename Documentation/devicetree/bindings/interconnect/{qcom,sdm660.yaml =
=3D> qcom,rpm-qos.yaml} (82%)
 create mode 100644 drivers/interconnect/qcom/icc-rpm-qos.c
 create mode 100644 drivers/interconnect/qcom/icc-rpm-qos.h
 create mode 100644 drivers/interconnect/qcom/msm8996.c
 create mode 100644 drivers/interconnect/qcom/msm8996.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8996.h


base-commit: 764a5bc89b12b82c18ce7ca5d7c1b10dd748a440
prerequisite-patch-id: c57f3ce25f51989e49eb700cd5bf2a1995965278
prerequisite-patch-id: 9a9e7fc49eb931f0994b4792f76f071951c28d23
prerequisite-patch-id: a7e6b1d2e041264bd6b6f3f0b4a8e19ab685ab68
prerequisite-patch-id: 59289cc1bd4c3febd5baa8a6c4617d570f2ef821
prerequisite-patch-id: 32f563209c1a1548f378b393d7829227d147322c
prerequisite-patch-id: 05224996d5d07ccb4ab8a3e34a0e57c46986d6de
prerequisite-patch-id: ef98b2922167163c86b4c85662809316c62ce1ae
prerequisite-patch-id: 5582031ca35ebb4adf900251520a6276bc289945
prerequisite-patch-id: 8ec39db70429f6866a76c939a0d18471c1417d90
prerequisite-patch-id: b7d6dfb9b77dff78e8d5027829bc44dfd9f1334d
prerequisite-patch-id: 3f2b983ab7a298bab386a0530719a84f60ec1c39
prerequisite-patch-id: 5fdea381c8be9a5710fa4f83e4749276a30fca68
prerequisite-patch-id: 743fc167b731cef58fcece815a896369ff982992
prerequisite-patch-id: e9dfad224f98b1f4a28041928dcdad1146027661
prerequisite-patch-id: 2358ba0db7092d013c11df8978adef08ecb47f1d
prerequisite-patch-id: 8012f82befa0b8aa8a35d650c0eac4d76cd2222c
prerequisite-patch-id: cf40e4f9154956d33ae63713f062f9deb4686d54
prerequisite-patch-id: 48d3965d8574c10f65c3c7381655a15ba27f1676
prerequisite-patch-id: ef501020410a45da108bd5d1ea10f2e4ad639ae5
prerequisite-patch-id: a8824522f0a8d1ce425a742d8a7a03d5c4670a96
prerequisite-patch-id: eed0e4b0684bab84b87d6b021844effd3e2bc7ee
prerequisite-patch-id: d804a7e51e59c59aa519da423c9874ac88cae3e4
prerequisite-patch-id: cf1d11fc13409c5d016988053fd2f063d7351abf
prerequisite-patch-id: 673a94d9ad698bff1c2fdb496d93666a09eff98c
prerequisite-patch-id: d57f0f27d75f414ba270f285197e4ac2f96bcdf4
prerequisite-patch-id: 30b7fe92fb695a89bc511476e5520713cc80f490
prerequisite-patch-id: d857aa31604cdb25a4f03c5cca84510dffac2d79
prerequisite-patch-id: 5a62763ca29ac35070295360bb8bc5ee149a555a
prerequisite-patch-id: ba019b45f4206d2373a3556f7cf16654ff1a441d
prerequisite-patch-id: 43d6b3dd93f517008b2b1bef374be5881751fff7
prerequisite-patch-id: 3019209111d80fbeab5952df1642f1fb946f6276
prerequisite-patch-id: 8bb51fca98655936022df222b632daf3f7422dd9
prerequisite-patch-id: 5225c9afa157bf36c6d25f6d8cb096151a254592
prerequisite-patch-id: 44a7eef149d160b79561e56e322477858fcb16a7
prerequisite-patch-id: 1cff3acf70dedd315dfde2e011cba93b7e40da8a
prerequisite-patch-id: c18e6baebb38a2c8b8f53033d1b0c8cc7d497bc3
prerequisite-patch-id: 7d0ae73cc2ca36bb47918d0f10ccda8cb3f22820
prerequisite-patch-id: 7b9ebbc69b48afab89f77fa707ba4fd0e2797ffd
prerequisite-patch-id: aec3aa54664ccc4ae07b1223a87666691228ecbf
prerequisite-patch-id: 45df79ab5715ce6c815ecf9f814274af2533449c
prerequisite-patch-id: 7f0b4cb27d246cbdc304b1d1719d66de9984057f
prerequisite-patch-id: 1b63f27a2bd234706dc4ed4c0d2350074ca8c595
prerequisite-patch-id: c568957615c3d9167bb5e367381ea6f82b3817f3
prerequisite-patch-id: dc621572fdf2985ada7481b3d064a8beee78d7ae
prerequisite-patch-id: 4780999ddedea513b4782b6689efc60c19de3467
prerequisite-patch-id: 38c04714b0f739dbf7e88cbcaae35097e76fb42a
prerequisite-patch-id: 68afe116efeaacf1fb36c6edd31a328522a785a4
prerequisite-patch-id: d98e15a86de12d9fdd87121962ae4ce1a7109455
prerequisite-patch-id: 77f101b82fee9e17e2efb899ca55f3820f16f63d
prerequisite-patch-id: 34b56db82ede48d3b36a3bc5cf1925059b72508e
prerequisite-patch-id: b9df65b7d06423a04cba963d55e6abdad6dd6e3c
prerequisite-patch-id: 37b7e60c56a99f14ffbf22c2a9da122d6b57b614
prerequisite-patch-id: f8c04273b7f71ad26246663750135f807a266878
prerequisite-patch-id: 20c1fa382653e640b829b091e231306b5f5adee6
prerequisite-patch-id: cbbff8f1bc46a4078aaa2e0b1a3ddd9ef855b5e9
prerequisite-patch-id: ceab86021c25817e9e4d974bc7b8d165f7e5009f
prerequisite-patch-id: 1085e180304a1eff2f058c442916d57449d71e6a
prerequisite-patch-id: c35afa1701d0c724b986abb6e654eec849c47b1e
prerequisite-patch-id: 035e63dfb412ee2519d88e868df57d4df90ddadb
prerequisite-patch-id: 74aa8baed9cb23a97b58af368392b05ea6ac4bd4
prerequisite-patch-id: 4cc71cb2034f54579a34a69578a779a67084e93a
prerequisite-patch-id: 3c1065ce84bb415bfcfafd77438c06f0a1da8df4
prerequisite-patch-id: 3bbafe19a04acde07e296192f0ac0a4724eae2cc
prerequisite-patch-id: 25a14dfc167d1f07333705082c3f99153b5cd08b
prerequisite-patch-id: 88c11ca4ca039d0ae69aa5bea699d75c01e17a88
prerequisite-patch-id: 38825e9becd50d91ac9c9ce6e1b7bc7683ea2edc
prerequisite-patch-id: 8344af6301ef3808254c36cbab26ac423543b333
prerequisite-patch-id: 4410ab4d30e6a39e4bd1948a73cbd000891518f9
prerequisite-patch-id: c2079cb7c11cab005dd8f4db1115320b4aed3a56
prerequisite-patch-id: c3a6934240d5bc7b90a5bee0304f967756886663
prerequisite-patch-id: 4f350a5110d4ec6f9389250af4197955361e7231
prerequisite-patch-id: c550576361e53761a903d3f823ce155c7ead19f5
prerequisite-patch-id: fe77ee0b12222dedb52fd8aa70d2fb33db35c9dd
prerequisite-patch-id: 5267708a4214499e1e81ab480e8144e46fb46831
prerequisite-patch-id: d4598bc0f2789116c90718cd7ce9216196b47d1f
prerequisite-patch-id: 369df195d0f0403473673dfcde0399ea2e600a18
prerequisite-patch-id: ba32a8b295bd339dcab5d1a797f4428e70b1a6c6
prerequisite-patch-id: 3837ca08f5296267964cd5bf1168ca0a6e1da590
prerequisite-patch-id: 8ec22fe40a2cc77e3f6b35f1b0379e21f90ab246
prerequisite-patch-id: d3d7a72ed9bb75ca96f28f4790db29928533fc1c
prerequisite-patch-id: ae072d2bf361b864bee9adc5e9afaa2de425a19a
prerequisite-patch-id: c9bcc797f1a9c23163ece8513d96399f0cfb3ed5
prerequisite-patch-id: 74da34ba9a13a223b8887ebe71fa595a4393b79e
prerequisite-patch-id: 56151ecf5468720ee65f0fc749cab395c4edb2ba
prerequisite-patch-id: cac0d3332ea10c8d8bec1b9f74cfecce48e0f2bf
prerequisite-patch-id: 290e36ee466d4d40aa6734c4c5fc21e01e4f01f0
prerequisite-patch-id: eaafa2162dcae0cde681c7e5bfc15ca297a6e68e
prerequisite-patch-id: ae8c4b392c3d9a6a951445b97d4fd6fa4003ac38
prerequisite-patch-id: 477a917765390681c69ae788b038ce339e09ed43
prerequisite-patch-id: 570a9ba575d3ef3b9536826284a9e71d28d0237c
prerequisite-patch-id: a671674b8b6a5444cd6f27972d2cd3682845bc77
prerequisite-patch-id: aa475c35970c6a5c907eb845cebb551f589f3a92
prerequisite-patch-id: a0e6ac408f413e5e08ccd50ddc2be998b6b5cbec
prerequisite-patch-id: 95b5b190a072669f87f4f58e848badea2dacaa77
prerequisite-patch-id: 09a07e5fb9f6455b2c255615084ffc42b5298371
prerequisite-patch-id: 373b6f1320abe5ce69c35225050fecdcd32ac940
prerequisite-patch-id: a332401f08edc88c31f4fd9786396239dfcbff3b
prerequisite-patch-id: 182240d77a1d9e15a4f7facbe8d8a1d9cf947723
prerequisite-patch-id: 51c0a3271a18fcdc360b04ea2892c14a2868ae2a
prerequisite-patch-id: dd54ff1d520f6fdb5f768952328f14e5037aa781
prerequisite-patch-id: 6d6029149931f47754b7938960bb9c162035710c
prerequisite-patch-id: ace503a8d59f2b485159d97fff33717102f6577d
prerequisite-patch-id: f724b4c810eb388528b6dd7d3db1754e5c5f8a9f
prerequisite-patch-id: 74a44b36c2f490661f9fa279c2e8e44a2cec5364
prerequisite-patch-id: babcd29a2720977591bb2befb67eb1f21d995e9c
prerequisite-patch-id: 88df830d297bcef2edafd53b04f4360b392f304a
prerequisite-patch-id: 386eb50a20069952700719ffba82bab385131846
prerequisite-patch-id: 9645592f69fc6631e64ac8d69e2075c97ecde1e6
prerequisite-patch-id: 36053accdcc9371740125f2b7529619c7ab22336
prerequisite-patch-id: d88458895d4c91ae28e33b22899cc54c3d107a56
prerequisite-patch-id: bb2ed02f78c1369192107a1b814694308c0a9775
prerequisite-patch-id: 2381e27e6b8c2fda852e254b6e329264ef9299f4
prerequisite-patch-id: c7c14c2045e32fce6978307887c22e402af31633
prerequisite-patch-id: b2ae92f6f618e03374636c23bdedd5e3dc5c87ee
prerequisite-patch-id: adfb314bbe8c479f2baf18a1871215913af4d42e
prerequisite-patch-id: 5f05156a9165ae2fe1f679e7bc89c01427d4bd0b
prerequisite-patch-id: 4e39112a25682a084d5621fe5f288262b1e3bc67
prerequisite-patch-id: a676894193d2354555bb5f83c65fb8d36020c774
prerequisite-patch-id: 6fa4836b8187b4ae6212e9d6ee712a19f18b8f6b
prerequisite-patch-id: 9ae76fd97381dcc4402583ebbfe5bc8658efa89f
prerequisite-patch-id: 5e21604ab3c382b8f56ab5924f39a6fc8889fae6
prerequisite-patch-id: 53b63783b6b66f4ab4aa686288503a5ae668ec3c
prerequisite-patch-id: 78cff47a7e1730baef8ac607ed6a6c36cef4ca4b
prerequisite-patch-id: 39a611c4c5535f9d1772e3b5f88f6abf2c224457
prerequisite-patch-id: f02ed74a8fc614794bd4317f8cab526f68ad8a01
prerequisite-patch-id: bdddf98173cdb0c4fdd79973d0a47b2bbf267f10
prerequisite-patch-id: f3b8afd50ac9220906b8aa7c0d22ef76c52555ac
prerequisite-patch-id: c29bfef1c377e2e2f21da27ace87e4773ceb46c8
prerequisite-patch-id: 87f14b99e0061194980ba4380e4a49c3799a0bbf
prerequisite-patch-id: f556aced10cb5cf356b934efe2237de264f2831d
prerequisite-patch-id: b8799410be2222d7a8c3d09e587f288de41522c8
prerequisite-patch-id: bac076c1a425fd479fb9971f270dcee281b028fb
prerequisite-patch-id: cb6ef889c29c41a2b0b3b2ed3cdbdc7a342a72eb
prerequisite-patch-id: be27f629f9ac70529a170399ea8c2a01c1f48913
prerequisite-patch-id: da46b416dfe049b0583217bb743afbc2aad4775a
prerequisite-patch-id: 5492d98b073dcdd89753fbdb45210d11f050cc11
prerequisite-patch-id: 40505e6ff73b41cf05508c6a69d0a618b2b19b53
prerequisite-patch-id: 5092570b04fd158acbcfd54662c1596c14401fb8
prerequisite-patch-id: 2b420afe90388b42c595785b5825bde08a3004fb
prerequisite-patch-id: a091cfb0e43a959e8db5740ad93644890a1df62d
prerequisite-patch-id: bd12ae713e29b2ffe60d9c095b116a17bde7845b
prerequisite-patch-id: 6ac5299b3de728348a6557414c262004bf576fc2
prerequisite-patch-id: bff6ec92673524f77fbb79059351c8cc3f3f3486
prerequisite-patch-id: 5ff6800b93d3c3dd1dd1309982e4331dbac644de
prerequisite-patch-id: 94f3a5769bbd2c7c423034fc4f6058963874c419
prerequisite-patch-id: acb16d91513af0bc6d1a0bf7a61ba0dffc675544
prerequisite-patch-id: 8d44c3fec85ced5a11b2c2cf0c95f420e9923407
prerequisite-patch-id: 6d35d2b42f7fc2846933d57bda2118f8657d3f67
prerequisite-patch-id: eb36934e4dacd9e4eeed16a8d7e975e9db9340c7
prerequisite-patch-id: b74088ba0f50b752b60c622b79a87d7027900876
prerequisite-patch-id: 413c56a1db2f247f157c3eaec28d7f4edc75f92d
prerequisite-patch-id: 1b514030576fe417b9c39128d08f1e9ab63764dd
prerequisite-patch-id: 71126ff2526e78922a4af08245a8ae11b92f074c
prerequisite-patch-id: 09df1c8749b2929b2868af775f439e35e3290542
prerequisite-patch-id: c0062f2d3e9372b1c1378d2682217cff889a6d77
prerequisite-patch-id: 53cf81732a82e13f8863112dec8a06546c3d5737
prerequisite-patch-id: f6bfc82ccf56841b28d010d96d46d812e2d723bd
prerequisite-patch-id: 2725de3df54597b00cc5d4aa833998e569a92d3f
prerequisite-patch-id: b85fcc3d579c81f1bfbaca8ad30faf1b42c4038f
prerequisite-patch-id: abce98e58d5686ee85231b4593434865eb81b4df
prerequisite-patch-id: 86a392c3f7be55c25379da6930e0e82701f6249e
prerequisite-patch-id: e3d85c60282f8dbb3dd1df06bad6bdb10fbff8ed
prerequisite-patch-id: 69d82108d7f769d2633d292f56b3c3afacf8e6bc
prerequisite-patch-id: 1a264f72d54adb091848d5995f169d13f55e8e48
prerequisite-patch-id: b3fd52345afb885f3d6fdcd7bfa83d766c0bf64c
prerequisite-patch-id: 0b6671cb5c38fec87470db975ae72d00f73e8b45
prerequisite-patch-id: fb5ee27c0eaa61627d4aa14aaa4c09c0a63ef2e7
prerequisite-patch-id: c6d12a8c2a9b8ef389b17ca9f54cb76ab2201838
prerequisite-patch-id: bf19ad2b692f339d89256b1a482db18165c5ddd3
prerequisite-patch-id: 781313ced848194657806487d623d75cd1828345
prerequisite-patch-id: 998e14d283a0f97b9ef78cda6fb54dcad361778d
prerequisite-patch-id: 8f6845c8f62233d5ef82abc53f891a9871e253a8
prerequisite-patch-id: 4dcf590c3074856c86d675b9b633df305b540265
prerequisite-patch-id: 0b879c760da72448e0f10da34f9b14398f10c984
prerequisite-patch-id: 7cc547afa1459a159af5c41ec37753bef8bc8c38
prerequisite-patch-id: 58bb162460d8b52e4b955027c57f1655d2516fa4
prerequisite-patch-id: 3fccfda188408256c96654e83184af451733ab63
prerequisite-patch-id: 949a0cd7b26cab691923cc20d3a35ec470771581
prerequisite-patch-id: 076355697d2fff1f5fc051e70c11cc6743e30c45
prerequisite-patch-id: 18a71c498e9851ad4e8d5b04d93e14b612007142
prerequisite-patch-id: 88f79d6863421e445fee72d7f8a6d73ca6b7f440
prerequisite-patch-id: 036bb46212fea2db9e6fc9b766e75d10c82784f2
prerequisite-patch-id: f6cfd80469c376a248eb9248de1cc2d1512b817a
prerequisite-patch-id: ed30afabaad01f5fd2e2ebf1e834927979de1340
prerequisite-patch-id: 92558e56b73ec4d33ad6c8abe0430ea0a7f9dc1f
prerequisite-patch-id: dace8255d248ebfcca58a0b96cd5e7463e1c2605
prerequisite-patch-id: cf645d84b2fa7e07a1f5349a94a20c91e2060150
prerequisite-patch-id: a7b88ec2d84e3abf53e44018f3c4251dbef87b8f
prerequisite-patch-id: 1275a9c0dd73a9837259ee6cccdaf7a929f9f3d5
--=20
2.32.0


